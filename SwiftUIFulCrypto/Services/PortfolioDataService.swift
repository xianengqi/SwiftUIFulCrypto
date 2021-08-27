//
//  PortfolioDataService.swift
//  SwiftUIFulCrypto
//
//  Created by 夏能啟 on 8/27/21.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error Loading CoreData! \(error)")
            }
            self.getPortfolio()
        }
    }
    
    // MARK: PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // 这是精简后的写法与下面注释的代码逻辑一样
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
        // 这是更易读的写法
//        if let entity = savedEntities.first(where: { (savedEntity) -> Bool in
//            return savedEntity.coinID == coin.id
//        }) {
//
//        }
    }
    
    // MARK: PRIVITE
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities. \(error)")
        }
    }
    
    // Add
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    // Update
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    // Remove
    private func delete(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    // Save
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error Saving to CoreData! \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
}
