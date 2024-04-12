//
//  ItemViewModel.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import Foundation
import RealityKit

class ItemViewModel: ObservableObject {
    @Published var item: InventoryItem?
    @Published var entity: ModelEntity?
    
    func getEntity() {
        guard let item else { return }
        Task { @MainActor in
            entity = try await ModelEntity(named: item.name)
        }
    }
}
