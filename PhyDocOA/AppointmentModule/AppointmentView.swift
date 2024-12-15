//
//  AppointmentView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct AppointmentView: View {
    @StateObject var viewModel = AppointmentViewModel()

    var startOver: () -> Void
    var completion: () -> Void
    
    var body: some View {
        VStack {
            StepStatusView(completion: startOver, stepNumber: viewModel.currentStep.rawValue)
            viewForStep(viewModel.currentStep)
            Spacer()
            NavigationButtonsStackView(
                backButtonAction: viewModel.goBackStep,
                nextButtonAction: viewModel.goNextStep
            )
        }
        .environmentObject(viewModel)
        .safeAreaPadding(20)
        .ignoresSafeArea(.keyboard)
        .onAppear {
            viewModel.completion = completion
        }
    }
    
    @ViewBuilder
    private func viewForStep(_ step: AppointmentStep) -> some View {
        switch step {
        case .selectAppointmentType:
            SelectAppointmentTypeView()
        case .selectPerson:
            SelectPersonView()
        case .selectTimeDate:
            SelectTimeDateView()
        case .confirmAppointment:
            ConfirmAppointmentView()
        }
    }
}
