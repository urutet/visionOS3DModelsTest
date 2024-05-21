//
//  ItemView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import RealityKit
import RealityKitContent
import SwiftUI

private enum Constants {
    static let maxScale = 4.0
}

struct ItemView: View {
    @State var viewModel: ItemViewModel
    
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
            isEntitySelected = entity != selectedEntity
        }
    }
    
    @State var isAnimationAvailable: Bool = false
    
    @State var isEntitySelected: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if let name = selectedEntity?.name,
                       let partName = viewModel.item.partName[name] {
                        Text(partName)
                            .font(.largeTitle)
                            .padding()
                    } else {
                        Text(viewModel.item.name)
                            .font(.largeTitle)
                            .padding()
                    }
                    
                    if let name = selectedEntity?.name,
                       let description = viewModel.item.partDescription[name] {
                        Text(description)
                            .padding()
                    } else {
                        Text(viewModel.item.description ?? "")
                            .padding()
                    }

                }
                .glassBackgroundEffect(displayMode: .always)
                
                RealityView { content in
                    do {
                        entity = try await Entity(named: viewModel.item.name)
                        selectedEntity = entity
                        guard let entity else { return }
                        entity.generateCollisionShapes(recursive: true)
                        entity.addComponents([InputTargetComponent(allowedInputTypes: .all),
                                              GestureComponent(canDrag: true, canScale: true, canRotate: true)])
                        let children = entity.findChildren(of: viewModel.item.rootName)
                        children.forEach { child in
                            child.components.set(HoverEffectComponent())
                        }
                        content.add(entity)
                    } catch {
                        debugPrint("ITEM INIT ERROR: \(error)")
                    }
                } update: { content in
                    guard let selectedEntity else { return }
                    guard selectedEntity != entity else {
                        content.entities.removeAll()
                        guard let entity else { return }
                        content.add(entity)
                        return
                    }
                    content.entities.removeAll()
                    selectedEntity.generateCollisionShapes(recursive: true)
                    selectedEntity.addComponents([InputTargetComponent(allowedInputTypes: .all),
                                                  GestureComponent(canDrag: true, canScale: true, canRotate: true)])
                    content.add(selectedEntity)
                }
                .installGestures()
                .simultaneousGesture(
                    TapGesture()
                        .targetedToAnyEntity()
                        .onEnded { value in
                            debugPrint(value.entity)
                            selectedEntity = value.entity.clone(recursive: true)
                            guard let entity else { return }
                            // Sets the scale of the root entity to the selected entity
                            selectedEntity?.transform.scale = entity.transform.scale
                            selectedEntity?.transform.rotation = entity.transform.rotation
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
            .opacity(isEntitySelected ? 1 : 0)
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
