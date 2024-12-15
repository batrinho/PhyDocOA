//
//  WarningView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 15.12.2024.
//

import SwiftUI

struct WarningView: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack {
                Image("warning")
                Spacer()
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Отмена и изменение времени приема может стоить денег.")
                    .font(.onestLight(size: 16))
                    .foregroundStyle(Color.textBrown)
                    .multilineTextAlignment(.leading)
                
                Button {
                    print("Подробнее tapped")
                } label: {
                    Text("Подробнее")
                        .font(.onestRegular(size: 16))
                        .foregroundStyle(Color.textBrown)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(.white)
                        .cornerRadius(16)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 122, maxHeight: 122, alignment: .leading)
        .background(Color.customBeige)
        .cornerRadius(20)
    }
}
