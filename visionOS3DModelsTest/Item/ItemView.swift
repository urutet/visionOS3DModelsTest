//
//  ItemView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct ItemView: View {
    @StateObject var viewModel: ItemViewModel
    
    @Environment(\.openWindow) var openWindow
    
    // Rotations
    
    // - TODO: Refactor to incapsulate these properties in component
    // `https://developer.apple.com/documentation/realitykit/transforming-realitykit-entities-with-gestures?changes=_8`
    @State var angle: Angle = .degrees(0)
    @State var startAngle: Angle?
    @State var axis: (CGFloat, CGFloat, CGFloat) = (.zero, .zero, .zero)
    @State var startAxis: (CGFloat, CGFloat, CGFloat)?
    @State var scale: Double = 1
    @State var startScale: Double?
    @State var entity: Entity? {
        didSet {
            guard let entity else { return }
            isAnimationAvailable = !entity.availableAnimations.isEmpty
        }
    }
    
    @State var selectedEntity: Entity? {
        didSet {
            isBackAvailable = entity != selectedEntity
        }
    }

    @State var isAnimationAvailable: Bool = false
    
    @State var isBackAvailable: Bool = false
    
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

                RealityView { content in
                    do {
                        entity = try await Entity(named: viewModel.item.name)
                        selectedEntity = entity
                        guard let entity else { return }
                        entity.generateCollisionShapes(recursive: true)
                        entity.components.set(InputTargetComponent(allowedInputTypes: .all))
                        content.add(entity)
                    } catch {
                        debugPrint(error)
                    }

                } update: { content in
                    guard let selectedEntity, selectedEntity != entity else {
                        content.entities.removeAll()
                        guard let entity else { return }
                        content.add(entity)
                        entity.isEnabled = true
                        return
                    }
                    selectedEntity.generateCollisionShapes(recursive: true)
                    selectedEntity.components.set(InputTargetComponent(allowedInputTypes: .all))
                    content.add(selectedEntity)
                    entity?.isEnabled = false
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
                            selectedEntity = value.entity.clone(recursive: true)
                        }
                )
            }
            
            Button(action: {
                playAnimation()
            }, label: {
                Text("Disassemble")
            })
            .disabled(!isAnimationAvailable)
            
            Button(action: {
                resetAnimation()
            }, label: {
                Text("Assemble")
            })
            .disabled(!isAnimationAvailable)
            
            Button(action: {
                resetScene()
            }, label: {
                Text("Back")
            })
            .disabled(!isBackAvailable)
        }
    }
    
    private func playAnimation() {
        if let animation = entity?.availableAnimations.first {
            // use animation.repeat() to repeat enimation indefinetly
            entity?.playAnimation(animation)
        }
    }
    
    private func resetAnimation() {
        if let animation = entity?.availableAnimations.first {
            var reversedDefinition = animation.definition
            reversedDefinition.speed = -1
            
            do {
                let reversedAnimation = try AnimationResource.generate(with: reversedDefinition)
                entity?.playAnimation(reversedAnimation)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    private func resetScene() {
        selectedEntity = entity
    }
}
