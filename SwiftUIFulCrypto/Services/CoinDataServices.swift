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
    
    private func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        // combine很棒
        // 获得订阅
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw URLError(.badServerResponse)
                      }
                return output.data
            }
            .receive(on: DispatchQueue.main)
        // 解码
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in //订阅者,因为它是一个订阅者，意味着随时可以取消，所以我们要把它存到`coinSubscription`
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
//            .store(in: &cancellables)

    }
}
