//
//  CoinImageViewMode.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/10/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    // `@Published` -> 发布订阅
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellabes = Set<AnyCancellable>()
    
    // 初始化
    init(coin: CoinModel) {
        self.coin = coin
        // 获取动态的image
        self.dataService = CoinImageService(coin: coin )
        self.addSubscribers()
        self.isLoading = true
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellabes)

    }
}
