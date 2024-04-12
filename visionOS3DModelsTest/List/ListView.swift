//
//  ListView.swift
//  visionOS3DModelsTest
//
//  Created by Ilya Yushkevich on 12/04/2024.
//

import SwiftUI

struct ListView: View {
    @StateObject var viewModel = ListViewModel()
    private let gridItems: [GridItem] = [.init(.adaptive(minimum: 240), spacing: 16)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                ForEach(viewModel.items) { item in
                    ListItemView(item: item)
                }
            }
            .padding()
        }
        .navigationTitle("Items list")
        .onAppear { viewModel.loadItems() }
    }
}
