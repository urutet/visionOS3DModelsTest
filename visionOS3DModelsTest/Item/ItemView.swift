//
//  ItemView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import RealityKit
import SwiftUI

struct ItemView: View {
    @StateObject var viewModel: ItemViewModel
    
    // Rotations
    
    // - TODO: Refactor to incapsulate these properties in component
    // `https://developer.apple.com/documentation/realitykit/transforming-realitykit-entities-with-gestures?changes=_8`
    @State var angle: Angle = .degrees(0)
    @State var startAngle: Angle?
    @State var axis: (CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero)
    @State var startAxis: (CGFloat, CGFloat, CGFloat)?
    @State var scale: Double = 1
    @State var startScale: Double?
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(viewModel.item.name)
                        .font(.largeTitle)
                        .padding()
                    
                    Text(viewModel.item.description ?? "")
                        .padding()
                }
                .glassBackgroundEffect(displayMode: .always)

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
                        entity.components.set(InputTargetComponent(allowedInputTypes: .all))
                        entity.generateCollisionShapes(recursive: true)
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
                        .targetedToAnyEntity()
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
                .simultaneousGesture(
                    TapGesture()
                        .targetedToAnyEntity()
                        .onEnded { value in
                            debugPrint(value.entity)
                        }
                )
            }
            
            Button(action: {
                viewModel.playAnimation()
            }, label: {
                Text("Disassemble")
            })
            .disabled(!viewModel.isAnimationAvailable)
            
            Button(action: {
                viewModel.resetAnimation()
            }, label: {
                Text("Assemble")
            })
            .disabled(!viewModel.isAnimationAvailable)
        }
    }
}
