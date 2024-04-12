//
//  ListItemView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import SwiftUI
import RealityKit

struct ListItemView: View {
    let item: InventoryItem
    
    @EnvironmentObject var navigation: Navigation
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        Button {
            navigation.selectedItem = item
            openWindow(id: "item")
        } label: {
            VStack {
                Model3D(named: item.name) { phase in
                    switch phase {
                    case .success(let resolvedModel3D):
                        resolvedModel3D
                            .resizable()
                            .scaledToFit()
                    default:
                        Text("")
                    }
                }
                Text(item.name)
            }
            .frame(width: 240, height: 240)
            .padding(32)
        }
        .buttonStyle(.borderless)
        .buttonBorderShape(.roundedRectangle(radius: 20))
    }
}
