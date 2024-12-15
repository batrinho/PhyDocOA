//
//  RootView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 14.12.2024.
//

import SwiftUI

struct RootView: View {
    var start: () -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Button(action: start) {
                    Text("Начать тестовое")
                        .padding()
                        .font(.onestBold(size: 25))
                        .foregroundStyle(.black)
                        .background(Color.customGray)
                        .cornerRadius(35)
                        .frame(width: 500, height: 60)
                }
                Spacer()
            }
            .frame(minHeight: 500)
        }
    }
}
