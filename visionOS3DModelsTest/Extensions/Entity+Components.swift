//
//  Entity+Components.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 25/04/2024.
//

import Foundation
import RealityKit

extension Entity {
    func addComponents(_ components: [Component]) {
        components.forEach { component in
            self.components.set(component)
        }
    }
    
    func findChildren(entity: Entity? = nil, name: String? = nil) -> [Entity] {
        let target = entity ?? self
        
        var foundChildren: [Entity] = []
        if (target.name == name) || (name == nil) {
            foundChildren.append(target)
        }
        
        for child in target.children {
            foundChildren = foundChildren + findChildren(entity: child, name: name)
        }
        
        return foundChildren
    }
    
    func findChildren(of name: String? = nil) -> [Entity] {
        var target: Entity
        if let name {
            target = self.findEntity(named: name) ?? self
        } else {
            target = self
        }
        
        var foundChildren: [Entity] = []
        target.children.forEach { child in
            foundChildren = foundChildren + findChildren(entity: child)
        }
        
        return foundChildren
    }
}
