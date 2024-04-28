//
//  ListViewModel.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items = [InventoryItem]()
    
    func loadItems() {
        self.items = [
            InventoryItem(name: "DslrCamera",
                          description: "Enjoy unparalleled control over the images created by the 102MP ultra-high resolution imaging sensor at the heart of GFX100S and use its unmatched flexibility to create the images that you have always dreamed of, down to the smallest of details. Using a back-illuminated design that – along with its family of GF lenses – optimizes light capture for every image at each one of its 102 million pixels, the full majesty of this camera is truly realized once the image data is passed through the quad-core X-Processor 4 imaging engine. This is what ultimately delivers the unsurpassed image quality and outstanding color reproduction that has now become synonymous with Fujifilm."),
            InventoryItem(name: "MagnifyingGlass"),
            InventoryItem(name: "Drummer"),
            InventoryItem(name: "Camera",
                          description: "Enjoy unparalleled control over the images created by the 102MP ultra-high resolution imaging sensor at the heart of GFX100S and use its unmatched flexibility to create the images that you have always dreamed of, down to the smallest of details. Using a back-illuminated design that – along with its family of GF lenses – optimizes light capture for every image at each one of its 102 million pixels, the full majesty of this camera is truly realized once the image data is passed through the quad-core X-Processor 4 imaging engine. This is what ultimately delivers the unsurpassed image quality and outstanding color reproduction that has now become synonymous with Fujifilm.",
                          rootName: "root",
                          partName: [
                            "Cube_010": "Camera Body",
                            "Cube_011": "Display",
                            "Cylinder_005": "Camera Lens",
                            "Cube_009": "Buttons",
                            "Cube_006": "Attachment Pad",
                          ],
                         partDescription: [
                            "Cube_010": "The Camera Body is the main chassis of the camera that houses the film plane or the imaging device as well as the main camera functions such as film claws or the digital ASA and shutter functions. The body does not include the lens itself",
                            "Cube_011": "The camera display shows the user helpful information about the photos and the camera. Here you will see the different camera settings you can tweak to alter your exposure, ISO, shutter speed, and more. You can also access other menus using this display to change the settings on your camera.",
                            "Cylinder_005": "A camera lens is the part of a camera that directs light to the film or, in a digital camera, to a computer chip that can sense the light. Many cheap lenses are plastic but better ones are made from glass. The lens makes an image by focusing the light.",
                            "Cube_009": "Buttons Description",
                            "Cube_006": "Attachment Pad",
                         ]),
        ]
    }
}
