//
//  ItemViewModel.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import Foundation
import RealityKit

class ItemViewModel: ObservableObject {
    @Published var item: InventoryItem
    
    init(item: InventoryItem) {
        self.item = item
    }
}
