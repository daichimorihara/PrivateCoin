//
//  CoinImageView.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import SwiftUI

struct CoinImageView: View {
    @ObservedObject var vm: CoinImageViewModel
    let coin: Coin
    init(coin: Coin) {
        self.coin = coin
        vm = CoinImageViewModel(coin: coin)
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "questionmark.circle")
            }
        }
        .task {
            await vm.fetchCoinImage(urlString: coin.image)
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
    }
}
