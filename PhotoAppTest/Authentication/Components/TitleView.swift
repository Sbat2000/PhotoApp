//
//  TitleView.swift
//  PhotoAppTest
//
//  Created by Aleksandr Garipov on 17.08.2024.
//

import SwiftUI

struct TitleView: View {

    var text: LocalizedStringKey

    var body: some View {
        Text(text)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .font(.system(size: 32, weight: .bold))
            .foregroundStyle(Color.black.opacity(0.5))
            .padding()
            .padding(.bottom, 8)
    }
}
