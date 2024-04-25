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
                          rootName: "root"),
        ]
    }
}
