//
//  visionOS3DModelsTestApp.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 11/04/2024.
//

import SwiftUI

@main
struct visionOS3DModelsTestApp: App {
        
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
            }
        }
        .windowStyle(.volumetric)

        WindowGroup(for: InventoryItem.self) { item in
            if let item = item.wrappedValue {
                ItemView(viewModel: ItemViewModel(item: item))
            } else {
                EmptyView()
            }
        }
        .windowStyle(.plain)
    }
}
