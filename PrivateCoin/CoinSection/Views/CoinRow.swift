//
//  CoinRow.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import SwiftUI

struct CoinRow: View {
    
    let coin: Coin
    
    var body: some View {
        HStack {
            CoinImageView(coin: coin)
//            Image(systemName: "questionmark.circle")
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .fontWeight(.semibold)
            
            Text("(" + coin.name + ")")
                .fontWeight(.semibold)
            Spacer()
            VStack(alignment: .trailing) {
                Text(coin.currentPrice.asCurrency())
                    .fontWeight(.semibold)
                
                Text(coin.priceChangePercentage24h.asNumber())
                    .foregroundColor(coin.priceChangePercentage24h < 0 ? Color.theme.red : Color.theme.green)
                    
            }
            
        }
        .foregroundColor(.theme.base)
    }
}

struct CoinRow_Previews: PreviewProvider {
    static var previews: some View {
        CoinRow(coin: dev.coin)
    }
}
