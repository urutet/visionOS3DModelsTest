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

    // Make sure entity is `Entity` class. Animations don't work with
    // ModelEntity subclass
    @Published var entity: Entity?
    
    init(item: InventoryItem) {
        self.item = item
        Task { @MainActor in
            entity = try await Entity(named: item.name)
            playAnimation()
        }
    }
    
    func playAnimation() {
        if let animation = entity?.availableAnimations.first {
            // use animation.repeat() to repeat enimation indefinetly
            entity?.playAnimation(animation)
        }
    }
}
