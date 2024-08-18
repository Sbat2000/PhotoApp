//
//  FilterSelectionView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 18.08.2024.
//

import SwiftUI

import SwiftUI

struct FilterSelectionView: View {
    @Binding var selectedFilter: CIFilter?
    @Binding var showFilterSheet: Bool

    let filters: [CIFilter] = [
        CIFilter(name: "CISepiaTone")!,
        CIFilter(name: "CIPhotoEffectNoir")!,
        CIFilter(name: "CIPhotoEffectChrome")!,
        CIFilter(name: "CIPhotoEffectInstant")!,
        CIFilter(name: "CIPhotoEffectTransfer")!
    ]

    var body: some View {
        List(filters, id: \.name) { filter in
            Button(action: {
                selectedFilter = filter
                showFilterSheet.toggle()
            }) {
                Text(filter.name)
            }
        }
    }
}
