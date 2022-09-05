//
//  CoinService.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation

class CoinService {
    
    
    func downloadCoins() async throws -> [Coin] {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h"
        guard let url = URL(string: urlString) else {
            print("0")
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decoded = try? JSONDecoder().decode([Coin].self, from: data) {
                return decoded
            } else {
                print("1")
                throw URLError(.badURL)
            }
        } catch  {
            print("2")
            throw error
        }
    }
}
