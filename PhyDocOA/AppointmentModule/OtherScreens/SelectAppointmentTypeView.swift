//
//  SelectAppointmentView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct SelectAppointmentTypeView: View {
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            TitleView(title: viewModel.titleForCurrentStep())
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(AppointmentType.allCases) { type in
                        Button {
                            viewModel.appointmentType = type
                        } label: {
                            appointmentTypeButtonView(for: type)
                        }
                    }
                }
            }
            .scrollIndicators(.never)
        }
    }
    
    @ViewBuilder
    private func appointmentTypeButtonView(for type: AppointmentType) -> some View {
        let isSelected = type == viewModel.appointmentType
        
        let mainLabel = type.rawValue
        let description = viewModel.appointmentTypeDescription(for: type)
                
        VStack(alignment: .leading, spacing: 4) {
            Text(mainLabel)
                .font(.onestMedium(size: 20))
                .foregroundStyle(.black)
            Text(description)
                .font(.onestLight(size: 16))
                .foregroundStyle(Color.textGray)
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: 116, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.customBlue : .clear, lineWidth: 2)
        )
        .background(isSelected ? Color.customPurple : Color.customGray)
        .cornerRadius(12)
        .multilineTextAlignment(.leading)
    }
}
