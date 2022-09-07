//
//  PortDataService.swift
//  PrivateCoin
//
//  Created by Daichi Morihara on 2022/09/04.
//

import Foundation
import CoreData
import UIKit

class PortDataService {
    static let shared = PortDataService()
    
    private let container: NSPersistentContainer
    @Published var savedEntities = [PortEntity]()
    
    private init() {
        container = NSPersistentContainer(name: "PortContainer")
        container.loadPersistentStores { _, err in
            if let err = err {
                print("Failed to laod Core Data \(err)")
            }
            //
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            self.getPort()
        }
    }
    
    func updatePort(coin: Coin, amount: Double) {
        if let entity = savedEntities.first(where: {$0.id == coin.id}) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortEntity(context: container.viewContext)
        entity.id = coin.id
        entity.amount = amount
        applyChange()
    }
    
    private func delete(entity: PortEntity) {
        container.viewContext.delete(entity)
        applyChange()
    }
    
    private func update(entity: PortEntity, amount: Double) {
        entity.amount = amount
        applyChange()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch  {
            print("Failed to save to Core Data \(error)")
        }
    }
    
    private func getPort() {
        let request = NSFetchRequest<PortEntity>(entityName: "PortEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch  {
            print("Failed to fetch Core Data \(error)")
        }
    }
    
    private func applyChange() {
        save()
        getPort()
    }
    
}
