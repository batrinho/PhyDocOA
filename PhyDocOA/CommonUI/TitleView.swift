//
//  TitleView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 13.12.2024.
//

import SwiftUI

struct TitleView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.onestMedium(size: 32))
            Spacer()
        }
    }
}
