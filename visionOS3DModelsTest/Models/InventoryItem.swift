//
//  InventoryItem.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import Foundation

struct InventoryItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var name: String
    var description: String?
    var rootName: String?
    
    var partName: [String: String] = [:]
    var partDescription: [String: String] = [:]
}
