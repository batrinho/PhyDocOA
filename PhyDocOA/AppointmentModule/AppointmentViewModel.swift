//
//  AppointmentViewModel.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI
import UIKit

enum AppointmentStep: Int, CaseIterable {
    case selectAppointmentType
    case selectPerson
    case selectTimeDate
    case confirmAppointment
}

enum AppointmentType: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case onlineConsultation = "Онлайн-консультация"
    case clinicAppointment = "Записаться в клинику"
    case houseCall = "Вызвать на дом"
}

@MainActor
final class AppointmentViewModel: ObservableObject {
    @Published var currentStep: AppointmentStep = .selectAppointmentType
    @Published var appointmentType: AppointmentType = .onlineConsultation
    
    @Published var name: String = "Иванов Иван"
    @Published var iin: String = "041115486195"
    @Published var phoneNumber: String = "+7 707 748 48 15"
    @Published var address: String = "+7 707 748 48 15"
    
    @Published var slots: [Slot] = []
    
    @Published var selectedSlotId: Int = -1
    @Published var selectedSlotTime: String = ""
    @Published var selectedSlotDate: String = ""
    @Published var selectedSlotPrice: Int = 0
    
    @Published var backButtonTitle: String = "Назад"
    @Published var nextButtonTitle: String = "Дальше"
    
    var completion: (() -> ())?
    
    private let service = NetworkingService()
    private var stepCount: Int = 0
    
    func appointmentTypeDescription(for type: AppointmentType) -> String {
        switch type {
        case .onlineConsultation:
            return "Врач созвонится с вами и проведет консультацию в приложении."
        case .clinicAppointment:
            return "Врач будет ждать вас в своем кабинете в клинике."
        case .houseCall:
            return "Врач сам приедет к вам домой в указанное время и дату."
        }
    }
    
    func titleForCurrentStep() -> String {
        switch currentStep {
        case .selectAppointmentType:
            "Выберите формат приема"
        case .selectPerson:
            "Выберите кого хотите записать"
        case .selectTimeDate:
            "Выберите дату и время"
        case .confirmAppointment:
            "Подтвердите запись"
        }
    }
}

// MARK: - Navigation
extension AppointmentViewModel {
    func goNextStep() {
        stepCount += 1
        if currentStep == .confirmAppointment {
            Task {
                await bookSlot(slotID: selectedSlotId, type: appointmentType == .onlineConsultation ? "online" : "offline")
                completion?()
                stepCount = 0
            }
        }
        guard let nextStep = AppointmentStep(rawValue: stepCount) else { return }
        if nextStep == .confirmAppointment {
            withAnimation(.default) {
                backButtonTitle = ""
                nextButtonTitle = "Подтвердить и оплатить"
            }
        }
        currentStep = nextStep
    }
    
    func goBackStep() {
        stepCount -= 1
        guard let previousStep = AppointmentStep(rawValue: stepCount) else {
            stepCount = 0
            return
        }
        if previousStep == .selectTimeDate {
            withAnimation(.default) {
                backButtonTitle = "Назад"
                nextButtonTitle = "Дальше"
            }
        }
        currentStep = previousStep
    }
}

// MARK: - Networking
extension AppointmentViewModel {
    var slotsByDay: [String: [(time: String, price: Int, id: Int)]] {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "d MMMM',' EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        timeFormatter.dateFormat = "H:mm"
        
        var groupedSlots: [String: [(time: String, price: Int, id: Int)]] = [:]
        
        for slot in slots {
            let customDateFormatter = DateFormatter()
            customDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            guard let date = customDateFormatter.date(from: slot.datetime) else {
                print("Failed to parse datetime: \(slot.datetime)")
                continue
            }
            
            let dayDescription = dateFormatter.string(from: date)
            let time = timeFormatter.string(from: date)
            
            groupedSlots[dayDescription, default: []].append((time: time, price: slot.price, id: slot.id))
        }
        
        return groupedSlots
    }
    
    func loadSlots(type: String) async {
        do {
            slots = try await service.fetchSlots(type: type)
        } catch {
            print("Failed to load slots: \(error.localizedDescription)")
        }
    }
    
    private func bookSlot(slotID: Int, type: String) async {
        do {
            let success = try await service.bookSlot(slotID: slotID, type: type)
            if success {
                print("Slot \(slotID) booked successfully!")
            }
        } catch {
            print("Failed to book slot: \(error.localizedDescription)")
        }
    }
}
