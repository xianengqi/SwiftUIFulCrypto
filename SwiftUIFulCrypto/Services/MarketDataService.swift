//
//  MarketDataService.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/23/21.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    
    var marketDataSubscription: AnyCancellable?
    
    init () {
        getData()
    }
    
    private func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        // combine很棒
        // 获得订阅
        marketDataSubscription = NetworkingManager.download(url: url)
        // 解码
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGolbalData) in
                self?.marketData = returnedGolbalData.data
                self?.marketDataSubscription?.cancel()
            })
            
//            .store(in: &cancellables)

    }
}
