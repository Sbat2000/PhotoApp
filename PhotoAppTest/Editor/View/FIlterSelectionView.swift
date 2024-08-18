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

    let filters: [(name: LocalizedStringKey, filter: CIFilter)] = [
        (LocalizedStrings.sepiaTone, CIFilter(name: "CISepiaTone")!),
        (LocalizedStrings.noir, CIFilter(name: "CIPhotoEffectNoir")!),
        (LocalizedStrings.chrome, CIFilter(name: "CIPhotoEffectChrome")!),
        (LocalizedStrings.instant, CIFilter(name: "CIPhotoEffectInstant")!),
        (LocalizedStrings.transfer, CIFilter(name: "CIPhotoEffectTransfer")!)
    ]

    var body: some View {
        List {
            ForEach(filters.indices, id: \.self) { index in
                Button(action: {
                    selectedFilter = filters[index].filter
                    showFilterSheet.toggle()
                }) {
                    Text(filters[index].name)
                }
            }

            // Кнопка "Reset Filters" с локализованной строкой
            Button(action: {
                selectedFilter = nil
                showFilterSheet.toggle()
            }) {
                Text(LocalizedStrings.resetFilters)
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
        }
    }
}
