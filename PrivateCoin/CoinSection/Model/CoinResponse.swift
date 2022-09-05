//
//  CoinResponse.swift
//  PublicCoin
//
//  Created by Daichi Morihara on 2022/09/01.
//

import Foundation
/*
"id": "bitcoin",
  "symbol": "btc",
  "name": "Bitcoin",
  "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
  "current_price": 20027,
  "market_cap": 382735312178,
  "market_cap_rank": 1,
  "fully_diluted_valuation": 419970869394,
  "total_volume": 26986246969,
  "high_24h": 20402,
  "low_24h": 19962.52,
  "price_change_24h": -362.46919893339145,
  "price_change_percentage_24h": -1.77775,
  "sparkline_in_7d":
*/
struct Coin: Identifiable, Decodable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let priceChange24h: Double
    let priceChangePercentage24h: Double
    let sparklineIn7d: SparklineIn7D
    let holding: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case sparklineIn7d = "sparkline_in_7d"
        case holding
    }
    
    func updateAmount(amount: Double) -> Coin {
        return Coin(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, priceChange24h: priceChange24h, priceChangePercentage24h: priceChangePercentage24h, sparklineIn7d: sparklineIn7d, holding: amount)
    }
    var currentValue: Double {
        return (holding ?? 0) * currentPrice
    }
}



// MARK: - SparklineIn7D
struct SparklineIn7D: Decodable {
    let price: [Double]
}

