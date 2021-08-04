//
//  CoinModel.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/4/21.
//

import Foundation

// CoinGecko API Info
/*
 URL:
       https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h
 
 JSON Response:
 
 {
     "id": "bitcoin",
     "symbol": "btc",
     "name": "Bitcoin",
     "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
     "current_price": 38132,
     "market_cap": 713758337748,
     "market_cap_rank": 1,
     "fully_diluted_valuation": 798304782492,
     "total_volume": 26084878071,
     "high_24h": 38782,
     "low_24h": 37703,
     "price_change_24h": -650.091516651082,
     "price_change_percentage_24h": -1.67629,
     "market_cap_change_24h": -15295962062.68164,
     "market_cap_change_percentage_24h": -2.09806,
     "circulating_supply": 18775943,
     "total_supply": 21000000,
     "max_supply": 21000000,
     "ath": 64805,
     "ath_change_percentage": -41.3399,
     "ath_date": "2021-04-14T11:54:46.763Z",
     "atl": 67.81,
     "atl_change_percentage": 55961.16216,
     "atl_date": "2013-07-06T00:00:00.000Z",
     "roi": null,
     "last_updated": "2021-08-04T11:05:23.272Z",
     "sparkline_in_7d": {
       "price": [
         40065.83892536083,
         39377.92807162509,
       ]
     },
     "price_change_percentage_24h_in_currency": -1.676288339175785
   }
 
 */

// 数据模型类
// 把json数据字段自动转换成swiftUI https://app.quicktype.io/

struct CoinModel: Identifiable, Codable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H, marketCapChange24H, marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings:  Double?
    
    // 因为json数据里面定义的字段是下划线`current_price`, 我采用了驼峰命名法，所以要进行转换
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case atl
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
    
    // 更新
    func updateHolding(amount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: amount)
    }
    
    var currentHoldingsValue: Double {
        // 当前你的`currentHoldings`持有量币*当前价格`currentPrice`
        return (currentHoldings ?? 0) * currentPrice
    }
    
    // 排名
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
