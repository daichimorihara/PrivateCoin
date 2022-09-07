//
//  PortCoinCol.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/06.
//

import SwiftUI

struct PortCoinCol: View {
    let coin: Coin
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 60, height: 60)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.base)
            
            Text(coin.name)
                .font(.caption)
                .foregroundColor(.theme.secondary)
        }
    }
}

struct PortCoinCol_Previews: PreviewProvider {
    static var previews: some View {
        PortCoinCol(coin: dev.coin)
    }
}
