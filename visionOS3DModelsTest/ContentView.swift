    //
//  ContentView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 11/04/2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @State var cameraRotation: Angle = .zero
    @State var bottleRotation: Angle = .zero
    @State var camera = Entity()
    @State var bottle = Entity()
    
    var body: some View {
        RealityView { content in
            if let scene = try? await Entity(named: "Scene",
                                                in: realityKitContentBundle) {
                content.add(scene)
                print(scene)
            }
        } update: { content in
            if let scene = content.entities.first {
                Task {
                    camera = scene.findEntity(named: "camera") ?? Entity()
                    camera.components.set(InputTargetComponent())
                    camera.generateCollisionShapes(recursive: false)

                    bottle = scene.findEntity(named: "bottle") ?? Entity()
                    bottle.components.set(InputTargetComponent())
                    bottle.generateCollisionShapes(recursive: false)
                }
            }
        }
        .gesture(
            DragGesture()
                .targetedToEntity(camera)
                .onChanged { _ in
                    cameraRotation.degrees += 5.0
                    let m1 = Transform(pitch: Float(cameraRotation.radians)).matrix
                    let m2 = Transform(yaw: Float(cameraRotation.radians)).matrix
                    camera.transform.matrix = matrix_multiply(m1, m2)
                    // Keep starting distance between models
                    camera.position.x = -0.25
                }
        )
        .gesture(
            TapGesture()
                .targetedToEntity(camera)
                .onEnded { _ in
                    debugPrint("Camera clicked")
                }
        )
        .gesture(
            DragGesture()
                .targetedToEntity(bottle)
                .onChanged { _ in
                    bottleRotation.degrees += 5.0
                    bottle.transform = Transform(roll: Float(bottleRotation.radians))
                    // Keep starting distance between models
                    bottle.position.x = 0.25
                }
        )
    }
}
