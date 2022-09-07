//
//  PortRow.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/06.
//

import SwiftUI

struct PortRow: View {
    let coin: Coin
    let allocation: Double
    var body: some View {
        HStack {
            Text(coin.symbol.uppercased())
            Spacer()
            Text(coin.currentValue.asValue())
            Text(allocation.asNumber())
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
    }
 
}

struct PortRow_Previews: PreviewProvider {
    static var previews: some View {
        PortRow(coin: dev.coin, allocation: 3.0)
    }
}
