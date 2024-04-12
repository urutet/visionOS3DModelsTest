//
//  ItemView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import RealityKit
import SwiftUI

struct ItemView: View {
    @EnvironmentObject var navigation: Navigation
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ItemViewModel()
    
    // Rotations
    @State var angle: Angle = .degrees(0)
    @State var startAngle: Angle?
    @State var axis: (CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero)
    @State var startAxis: (CGFloat, CGFloat, CGFloat)?
    @State var scale: Double = 2
    @State var startScale: Double?
    
    var body: some View {
        RealityView { _ in
            
        } update: { content in
            if viewModel.entity == nil && !content.entities.isEmpty {
                content.entities.removeAll()
            }
            
            if let entity = viewModel.entity {
                if let currentEntity = content.entities.first, entity == currentEntity {
                    return
                }
                content.entities.removeAll()
                content.add(entity)
            }
        }
        .rotation3DEffect(angle, axis: axis)
        .scaleEffect(scale)
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    if let startAngle, let startAxis {
                        let _angle = sqrt(pow(value.translation.width, 2) + pow(value.translation.height, 2)) + startAngle.degrees
                        let axisX = ((-value.translation.height + startAxis.0) / CGFloat(_angle))
                        let axisY = ((-value.translation.width + startAxis.1) / CGFloat(_angle))
                        angle = Angle(degrees: Double(_angle))
                        axis = (axisX, axisY, 0)
                    } else {
                        startAngle = angle
                        startAxis = axis
                    }
                    
                }
                .onEnded { value in
                    startAngle = angle
                    startAxis = axis
                })
        .simultaneousGesture(
            MagnifyGesture()
                .onChanged { value in
                    if let startScale {
                        scale = max(1, min(3, value.magnification * startScale))
                    } else {
                        startScale = scale
                    }
                }
                .onEnded { _ in
                    startScale = scale
                }
        )
        .zIndex(1)
        .onAppear {
            viewModel.item = navigation.selectedItem
            viewModel.getEntity()
        }
    }
}
