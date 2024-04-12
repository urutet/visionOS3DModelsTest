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
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)
    }
}
