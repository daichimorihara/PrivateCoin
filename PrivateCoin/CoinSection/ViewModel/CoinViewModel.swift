//
//  CoinViewModel.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class CoinViewModel: ObservableObject {
    @Published var coins = [Coin]()
    @Published var filteredCoins = [Coin]()
    @Published var portAddCoins = [Coin]()
    @Published var searchText = ""
    @Published var portCoins = [Coin]()
    let service = CoinService()
    let portService = PortDataService.shared
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Task {
            await fetchCoins()
        }
        addSubscribers()
    }
    
    func addSubscribers() {
        // filteredCoins
        $searchText
            .combineLatest($coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map({(text, coins) -> [Coin] in
                guard !text.isEmpty else {
                    return coins
                }
                let lower = text.lowercased()
                return coins.filter({
                    $0.name.lowercased().contains(lower) ||
                    $0.symbol.lowercased().contains(lower) ||
                    $0.id.lowercased().contains(lower)
                })
            })
            .sink { [weak self] returnedCoins in
                self?.filteredCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // portCoins
        $coins
            .combineLatest(portService.$savedEntities)
            .map({ (coins, entities) -> [Coin] in
                coins
                    .compactMap { coin -> Coin? in
                        guard let entity = entities.first(where: { $0.id == coin.id }) else {
                            return nil
                        }
                        return coin.updateAmount(amount: entity.amount)
                    }
                    .sorted { $0.currentValue > $1.currentValue}
            })
            .sink { [weak self] returnedCoins in
                self?.portCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        //portAddCoins
        $searchText
            .combineLatest($coins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map({(text, coins) -> [Coin] in
                let lower = text.lowercased()
                return coins.filter({
                    $0.name.lowercased().contains(lower) ||
                    $0.symbol.lowercased().contains(lower) ||
                    $0.id.lowercased().contains(lower)
                })
            })
            .sink { [weak self] returnedCoins in
                self?.portAddCoins = returnedCoins
            }
            .store(in: &cancellables)
        
    }

    func updatePort(coin: Coin, amount: Double) {
        portService.updatePort(coin: coin, amount: amount)
    }
    
    func fetchCoins() async {
        if let fetched = try? await service.downloadCoins() {
            self.coins = fetched
        }
    }
    
    func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return coins
        }
        let lower = text.lowercased()
        return coins.filter({
            $0.name.lowercased().contains(lower) ||
            $0.symbol.lowercased().contains(lower) ||
            $0.id.lowercased().contains(lower)
        })
    }
    
    var totalValue: Double {
        var total: Double = 0
        for coin in portCoins {
            total += coin.currentValue
        }
        return total
    }
}
