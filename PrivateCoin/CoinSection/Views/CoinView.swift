//
//  CoinView.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/08/31.
//

import SwiftUI

struct CoinView: View {
    
    @StateObject var vm = CoinViewModel()
    
    var body: some View {
        VStack {
            Text("Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
            
            SearchBarView(searchText: $vm.searchText)
            
            HStack {
                Text("Coin")
                Spacer()
                Text("Price")
            }
            .padding(.horizontal)
            .foregroundColor(.theme.secondary)
            .font(.caption)
            
            List() {
                ForEach(vm.filteredCoins) { coin in
                    CoinRow(coin: coin)
                        .listRowInsets(.init(top: 10, leading: 5, bottom: 10, trailing: 5))
                }
            }
            .listStyle(PlainListStyle())
            
            Spacer()
            
        }
//        .task {
//            await vm.fetchCoins()
//        }
        .navigationBarHidden(true)
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView()
    }
}
