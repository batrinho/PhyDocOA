//
//  AppointmentDoneView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct AppointmentDoneView: View {
    var start: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 130)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Вы записаны на прием!")
                        .font(.onestSemiBold(size: 32))
                    Text("Мы отправим вам уведомление чтобы вы не забыли о приеме.\n\nЕсли захотите изменить или отменить запись, вы можете сделать на странице с записями.")
                        .font(.onestRegular(size: 16))
                }
                .foregroundStyle(.white)
                Spacer()
            }
            VStack {
                Spacer()
                Button(action: start) {
                    Text("Хорошо")
                        .font(.onestBold(size: 16))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                        .background(.white)
                        .cornerRadius(28)
                }
            }
        }
        .background(Color.customBlue)
        .safeAreaPadding(20)
    }
}
