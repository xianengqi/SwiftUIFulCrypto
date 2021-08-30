//
//  HomeViewModel.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/7/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    

    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataServices()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancelables = Set<AnyCancellable>()
    
    // 排序
    enum SortOption {
        case rank, rankReversed, holdings, holdingsReversed, price, pricereversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
//        dataService.$allCoins
//        // `weak self`是弱引用
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancelables)
//
        
        /// updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
        // 添加去抖动，··假如用户快速输入10次的时候可能要在数据库请求10次，如果数据库量大那就会在屏幕上体验不好卡顿。
        // 所以给添加防抖
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
        ///   把这串代码封装成一个私有函数`filterCoins`，方便调用
//            .map { (text, startingCoins) -> [CoinModel] in
//                guard !text.isEmpty else {
//                    return startingCoins
//                }
//
//                let lowercasedText = text.lowercased() // 转换为小写
//                return startingCoins.filter { (coin) -> Bool in
//                    return coin.name.lowercased().contains(lowercasedText) ||
//                    coin.symbol.lowercased().contains(lowercasedText) ||
//                    coin.id.lowercased().contains(lowercasedText)
//                }
//            }
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancelables)
        
        // updates portfolioCoins CoreData
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returndeCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeds(coins: returndeCoins)
            }
            .store(in: &cancelables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancelables)
        
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    // 主屏幕刷新按钮， 因为下啦刷新视频里没讲到，实现起来可能比较复杂，所以就采用简单的点击按钮刷新
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var updateCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updateCoins)
        // sort
        return updateCoins
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased() // 转换为小写
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    // 排序
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            // 这是简化的写法
             coins.sort(by: { $0.rank < $1.rank })
            // 这个写法和上面的写法一样
//            return coins.sorted { (coin1, coin2) -> Bool in
//                return coin1.rank < coin2.rank
//            }
        case .rankReversed, .holdingsReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
             coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .pricereversed:
             coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeds(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        
        }
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHolding(amount: entity.amount)
            }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        // 未简化的写法
//        let portfolioValue = portfolioCoins.map { (coin) -> Double in
//            return coin.currentHoldingsValue
//        }
        // 简化后的写法
        let portfolioValue = portfolioCoins.map({ $0.currentHoldingsValue }).reduce(0, +)
        
        // 获取24小时前自己纳入每枚硬币的价格
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            // 25% -> 25 -> 0.25
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue   // ` 110 / (1 + 0.1) = 100 `
        }
            .reduce(0, +)
        
        // 要获得百分比的计算方式是： 新的减去旧的除以旧的乘以100
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
