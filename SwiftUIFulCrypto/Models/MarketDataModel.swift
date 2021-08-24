//
//  MarketDataModel.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/23/21.
//

import Foundation

// JSON data:
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 {
   "data": {
     "active_cryptocurrencies": 9028,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 636,
     "total_market_cap": {
       "btc": 44383013.913958944,
       "eth": 669339394.1139706,
       "ltc": 11789949214.30285,
       "bch": 3251751125.2602763,
       "bnb": 4488674418.028413,
       "eos": 399887872682.3531,
       "xrp": 1745448471438.4805,
       "xlm": 5841769768177.916,
       "link": 77704852981.01102,
       "dot": 80270400304.07423,
       "yfi": 55572071.742923684,
       "usd": 2225339846219.781,
       "aed": 8173628748368.32,
       "ars": 216388256892653.06,
       "aud": 3098850270716.5815,
       "bdt": 189456303937763.22,
       "bhd": 839062163677.3212,
       "bmd": 2225339846219.781,
       "brl": 11969435430862.316,
       "cad": 2834226208243.206,
       "chf": 2039074450411.49,
       "clp": 1750519719679062.8,
       "cny": 14431773970704.504,
       "czk": 48474577870205.63,
       "dkk": 14112542293744.764,
       "eur": 1897683032602.2249,
       "gbp": 1627386578860.8328,
       "hkd": 17339514280767.576,
       "huf": 664241690698143.8,
       "idr": 32056576819757468,
       "ils": 7187300269687.733,
       "inr": 165072810174763.75,
       "jpy": 244958956786319.16,
       "krw": 2606938895484362,
       "kwd": 669958588763.0793,
       "lkr": 444568500616831.1,
       "mmk": 3663376975286243,
       "mxn": 45171875342876.03,
       "myr": 9404286190124.81,
       "ngn": 916394948673303.9,
       "nok": 19912765983885.227,
       "nzd": 3242849786825.6206,
       "php": 111638441587440.4,
       "pkr": 365892676291517.2,
       "pln": 8706337276775.956,
       "rub": 164865415177115.44,
       "sar": 8345473941973.106,
       "sek": 19463843726027.617,
       "sgd": 3024032119746.8267,
       "thb": 74237337269891.66,
       "try": 18843309935249.062,
       "twd": 62238304819074.836,
       "uah": 59390913500301.3,
       "vef": 222823278801.98633,
       "vnd": 50587287734613270,
       "zar": 33862773905941.773,
       "xdr": 1569485461402.0413,
       "xag": 94887178092.30197,
       "xau": 1242807797.3168242,
       "bits": 44383013913958.945,
       "sats": 4438301391395894.5
     },
     "total_volume": {
       "btc": 2657278.7170685492,
       "eth": 40074370.11651919,
       "ltc": 705882236.4614733,
       "bch": 194687298.05301052,
       "bnb": 268743781.6187958,
       "eos": 23941896675.89093,
       "xrp": 104502661398.45358,
       "xlm": 349755663396.0685,
       "link": 4652308030.2674055,
       "dot": 4805911260.377562,
       "yfi": 3327184.670066619,
       "usd": 133234489732.22183,
       "aed": 489367616096.6555,
       "ars": 12955494883225.219,
       "aud": 185532890752.32092,
       "bdt": 11343037794690.002,
       "bhd": 50235931119.04446,
       "bmd": 133234489732.22183,
       "brl": 716628349922.7004,
       "cad": 169689444640.3037,
       "chf": 122082496472.65524,
       "clp": 104806284763121.75,
       "cny": 864052312811.4039,
       "czk": 2902246889836.997,
       "dkk": 844939425555.8491,
       "eur": 113617176698.53912,
       "gbp": 97434115872.19434,
       "hkd": 1038143158820.0114,
       "huf": 39769162840170.98,
       "idr": 1919276133215087,
       "ils": 430314626150.6031,
       "inr": 9883160843796.098,
       "jpy": 14666066249702.74,
       "krw": 156081406663778.97,
       "kwd": 40111442244.29288,
       "lkr": 26616993998161.906,
       "mmk": 219331965330219.44,
       "mxn": 2704509053652.753,
       "myr": 563048953608.3705,
       "ngn": 54865962871728.84,
       "nok": 1192207661911.4597,
       "nzd": 194154361348.40344,
       "php": 6683963721168.219,
       "pkr": 21906552432999.79,
       "pln": 521261687952.22437,
       "rub": 9870743789056.512,
       "sar": 499656249862.7573,
       "sek": 1165330001828.799,
       "sgd": 181053413973.0339,
       "thb": 4444702577466.906,
       "try": 1128177697601.458,
       "twd": 3726302208830.7803,
       "uah": 3555824548949.2153,
       "vef": 13340769456.887354,
       "vnd": 3028738050822924,
       "zar": 2027415906806.2458,
       "xdr": 93967487683.85172,
       "xag": 5681040033.832984,
       "xau": 74408797.8256513,
       "bits": 2657278717068.5493,
       "sats": 265727871706854.94
     },
     "market_cap_percentage": {
       "btc": 42.34683123691343,
       "eth": 17.500814720571984,
       "ada": 4.052517619599343,
       "bnb": 3.4367016481232096,
       "usdt": 2.9176856437116854,
       "xrp": 2.6595044929807425,
       "doge": 1.896024939754911,
       "dot": 1.2747817398763244,
       "usdc": 1.2103623712467961,
       "sol": 0.9346775382614096
     },
     "market_cap_change_percentage_24h_usd": 2.1708975782236273,
     "updated_at": 1629716886
   }
 }
 */


struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    // 把Response里面的数据转换成驼峰命名
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        // 未优化的代码
//        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
//            return key == "usd"
//        }) {
//            return "\(item.value)"
//        }
        // 优化后的代码
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
