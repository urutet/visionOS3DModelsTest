//
//  visionOS3DModelsTestApp.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 11/04/2024.
//

import SwiftUI

@main
struct visionOS3DModelsTestApp: App {
    
    @StateObject var navigation = Navigation()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
                    .environmentObject(navigation)
            }
        }.windowStyle(.volumetric)

        WindowGroup(id: "item") {
            ItemView()
                .environmentObject(navigation)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 1, height: 1, depth: 1, in: .meters)
    }
}
