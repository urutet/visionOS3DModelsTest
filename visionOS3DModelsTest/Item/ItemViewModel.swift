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
    @Published var entity: Entity?
    
    func getEntity() {
        guard let item else { return }
        Task { @MainActor in
            entity = try await Entity(named: item.name)
            playAnimation()
        }
    }
    
    func playAnimation() {
        if let animation = entity?.availableAnimations.first {
            entity?.playAnimation(animation)
        }
    }
}
