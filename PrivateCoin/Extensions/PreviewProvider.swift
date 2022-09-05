//
//  PreviewProvider.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/08/31.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    
//    let article = Article(title: "Elon Musk reportedly wanted to entrust his fortune to a 34-year-old former pro gambler who dropped out of college to smoke weed - Yahoo Finance", url: "", urlToImage: "https://cdn.cnn.com/cnnnext/dam/assets/220716073629-05-biden-saudi-arabia-0716-super-tease.jpg")
    
    let coin = Coin(id: "bitcoin", symbol: "btc", name: "Bitcoin", image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579", currentPrice: 20027, priceChange24h: 362.46919893339145, priceChangePercentage24h: 1.77775, sparklineIn7d: SparklineIn7D(price: [
                21459.644902136883,
                21592.630757255276,
                21543.467034872054,
                21488.139330200192,
                21535.7797731082,
                21567.618336535055,
                21692.246376495772,
                21744.65371535301,
                21704.112965548393,
                21717.61828809006,
                21679.671948858286
    ]), holding: 3.1)
}
