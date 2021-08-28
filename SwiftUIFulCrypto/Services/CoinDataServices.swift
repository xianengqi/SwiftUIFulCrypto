//
//  CoinDataServices.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/7/21.
//

import Foundation
import Combine

class CoinDataServices {
    @Published var allCoins: [CoinModel] = []
    
    var coinSubscription: AnyCancellable?
    
    init () {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        // combine很棒
        // 获得订阅
        coinSubscription = NetworkingManager.download(url: url)
        // 解码
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
            
//            .store(in: &cancellables)

    }
}
