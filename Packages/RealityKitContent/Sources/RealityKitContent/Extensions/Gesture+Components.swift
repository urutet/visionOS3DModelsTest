/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
App-specific extension on Gesture.
*/

import Foundation
import RealityKit
import SwiftUI

// MARK: - Rotate -

/// Gesture extension to support rotation gestures.
public extension Gesture where Value == EntityTargetValue<RotateGesture3D.Value> {
    
    /// Connects the gesture input to the `GestureComponent` code.
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard let root = value.entity.findRoot() else { return }
            guard var gestureComponent = root.gestureComponent else { return }
            
            gestureComponent.onChanged(value: value)
            
            root.components.set(gestureComponent)
        }
        .onEnded { value in
            guard let root = value.entity.findRoot() else { return }
            guard var gestureComponent = root.gestureComponent else { return }
            
            gestureComponent.onEnded(value: value)
            
            root.components.set(gestureComponent)
        }
    }
}

// MARK: - Drag -

/// Gesture extension to support drag gestures.
public extension Gesture where Value == EntityTargetValue<DragGesture.Value> {
    
    /// Connects the gesture input to the `GestureComponent` code.
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard let root = value.entity.findRoot() else { return }
            guard var gestureComponent = root.gestureComponent else { return }
            
            gestureComponent.onChanged(value: value)
            
            root.components.set(gestureComponent)
        }
        .onEnded { value in
            guard let root = value.entity.findRoot() else { return }
            guard var gestureComponent = root.gestureComponent else { return }
            
            gestureComponent.onEnded(value: value)
            
            root.components.set(gestureComponent)
        }
    }
}

// MARK: - Magnify (Scale) -

/// Gesture extension to support scale gestures.
public extension Gesture where Value == EntityTargetValue<MagnifyGesture.Value> {
    
    /// Connects the gesture input to the `GestureComponent` code.
    func useGestureComponent() -> some Gesture {
        onChanged { value in
            guard let root = value.entity.findRoot() else { return }
            if var gestureComponent = root.gestureComponent {
                gestureComponent.onChanged(value: value)
                
                root.components.set(gestureComponent)
                
                return
            }
            
            if var gestureComponent = value.entity.gestureComponent {
                gestureComponent.onChanged(value: value)
                
                root.components.set(gestureComponent)
                
                return
            }
        }
        .onEnded { value in
            guard let root = value.entity.findRoot() else { return }
            guard var gestureComponent = root.gestureComponent else { return }
            
            gestureComponent.onEnded(value: value)
            
            root.components.set(gestureComponent)
        }
    }
}
