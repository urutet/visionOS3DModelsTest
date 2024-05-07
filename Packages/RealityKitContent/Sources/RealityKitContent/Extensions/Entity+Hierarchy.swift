//
//  Entity+Hierarchy.swift
//
//
//  Created by Ilya Yushkevich on 25/04/2024.
//

import RealityKit

public extension Entity {
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
    
    func findRoot() -> Entity? {
        guard
            self.parent != nil,
            !self.name.isEmpty
        else { return self }
        debugPrint(self.name)
        return self.parent?.findRoot()
    }
}
