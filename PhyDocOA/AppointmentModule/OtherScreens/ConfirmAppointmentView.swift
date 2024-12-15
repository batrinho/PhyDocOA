//
//  ConfirmView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct ConfirmAppointmentView: View {
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    var body: some View {
        VStack(spacing: 32) {
            TitleView(title: viewModel.titleForCurrentStep())
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    WarningView()
                    confirmAppointmentView()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    private func confirmAppointmentView() -> some View {
        VStack(spacing: 20) {
            doctorInfoView()
            infoBlocks()
            clientInfoView()
            paymentInfoView()
        }
    }
    
    @ViewBuilder
    private func doctorInfoView() -> some View {
        HStack {
            Image("oksana")
                .resizable()
                .frame(width: 72, height: 72)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Оксана Михайловна")
                    .font(.onestMedium(size: 16))
                Text("Офтальмолог")
                    .font(.onestRegular(size: 16))
                    .foregroundColor(Color.dayTextGray)
                HStack(spacing: 5) {
                    Image("star")
                    Text("4.9")
                    Image("dot")
                    Text("Шымкент")
                }
                .font(.onestRegular(size: 16))
                .foregroundColor(Color.dayTextGray)
            }
            Spacer()
            Button {
                print("chat tapped")
            } label: {
                Image("chat")
                    .frame(width: 50, height: 50)
                    .cornerRadius(28)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.borderGray, lineWidth: 2)
                    )
            }
        }
    }
    
    @ViewBuilder
    private func infoBlocks() -> some View {
        HStack(spacing: 12) {
            InfoBlock(title: "ВРЕМЯ", value: viewModel.selectedSlotTime)
            InfoBlock(title: "ДАТА", value: viewModel.selectedSlotDate.beforeComma())
            InfoBlock(title: "ЦЕНА", value: "\(viewModel.selectedSlotPrice)₸")
        }
    }
    
    @ViewBuilder
    private func clientInfoView() -> some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Формат приема:")
                    .font(.onestLight(size: 16))
                    .foregroundColor(.dayTextGray)
                Text(viewModel.appointmentType.rawValue)
                    .font(.onestRegular(size: 18))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Пациент:")
                    .font(.onestLight(size: 16))
                    .foregroundColor(.dayTextGray)
                Text(viewModel.name)
                    .font(.onestRegular(size: 18))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    private func paymentInfoView() -> some View {
        HStack(alignment: .center) {
            Image("visa")
                .resizable()
                .frame(width: 40, height: 20)
            
            VStack(alignment: .leading) {
                Text("•••• 4515")
                    .font(.onestMedium(size: 16))
                Text("03/24")
                    .font(.onestLight(size: 14))
                    .foregroundStyle(Color.dayTextGray)
            }
            Spacer()
            Text("\(viewModel.selectedSlotPrice)₸")
                .font(.onestMedium(size: 20))
            Image("arrow")
        }
        .padding()
        .background(Color.customGray)
        .cornerRadius(16)
    }
}

struct InfoBlock: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.onestMedium(size: 12))
                .foregroundColor(Color.dayTextGray)
            Text(value)
                .font(.onestRegular(size: 24))
        }
        .lineLimit(1)
        .padding(12)
        .background(Color.customGray)
        .cornerRadius(12)
    }
}
