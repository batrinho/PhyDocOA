//
//  NavigationButtonsStackView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct NavigationButtonsStackView: View {
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    var backButtonAction: () -> Void
    var nextButtonAction: () -> Void
    
    private var isDisabled: Bool {
        viewModel.currentStep == .selectTimeDate && viewModel.selectedSlotId < 0
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Button {
                backButtonAction()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                    Text(viewModel.backButtonTitle)
                        .font(.onestBold(size: 12))
                        .foregroundColor(.black)
                }
                .padding(16)
                .frame(height: 56, alignment: .center)
                .cornerRadius(28)
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            
            Button {
                nextButtonAction()
            } label: {
                Text(viewModel.nextButtonTitle)
                    .font(.onestBold(size: 16))
                    .foregroundColor(isDisabled ? Color.disabledTextGray : .white)
                    .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                    .background(isDisabled ? Color.disabledGray : Color.customBlue)
                    .cornerRadius(28)
            }
            .disabled(isDisabled)
        }
    }
}
