//
//  ListViewModel.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items = [InventoryItem]()
    
    func loadItems() {
        self.items = [
            InventoryItem(name: "DslrCamera"),
            InventoryItem(name: "MagnifyingGlass"),
            InventoryItem(name: "Drummer"),
        ]
    }
}
