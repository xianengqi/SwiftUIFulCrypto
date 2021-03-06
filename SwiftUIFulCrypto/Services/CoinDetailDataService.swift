//
//  CoinDetailDataService.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 9/1/21.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init (coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }

    func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        // combine很棒
        // 获得订阅
        coinDetailSubscription = NetworkingManager.download(url: url)
        // 解码
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
            
//            .store(in: &cancellables)

    }
}
