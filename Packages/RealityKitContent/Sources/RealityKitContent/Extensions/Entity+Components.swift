//
//  Entity+Components.swift
//
//
//  Created by Ilya Yushkevich on 25/04/2024.
//

import RealityKit

public extension Entity {
    func addComponents(_ components: [Component]) {
        components.forEach { component in
            self.components.set(component)
        }
    }
}
