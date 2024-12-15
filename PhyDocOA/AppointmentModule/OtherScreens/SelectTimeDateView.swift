//
//  SelectTimeDateView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct SelectTimeDateView: View {
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    @State private var showMoreWasPressed: Bool = false
    @State private var isLoading: Bool = true  // Track loading state
    
    let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TitleView(title: viewModel.titleForCurrentStep())
            WarningView()
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                selectTimeDateView()
            }
        }
        .task {
            await loadSlots()
        }
    }
    
    @ViewBuilder
    private func selectTimeDateView() -> some View {
        ScrollView {
            VStack(spacing: 24) {
                    ForEach(getVisibleDays(), id: \.self) { day in
                        VStack(alignment: .leading, spacing: 16) {
                            Text(day)
                                .font(.onestRegular(size: 20))
                                .foregroundStyle(Color.dayTextGray)
                            
                            LazyVGrid(columns: columns) {
                                ForEach(viewModel.slotsByDay[day] ?? [], id: \.time) { slot in
                                    SlotView(
                                        id: slot.id, 
                                        date: day,
                                        time: slot.time,
                                        price: slot.price
                                    )
                                }
                            }
                        }
                    }
                    
                    if showMoreWasPressed == false && viewModel.slotsByDay.count > 2 {
                        Button {
                            showMoreWasPressed = true
                        } label: {
                            Text("Показать ещё")
                                .font(.onestMedium(size: 16))
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                                .background(.white)
                                .cornerRadius(28)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 28)
                                        .stroke(Color.borderGray, lineWidth: 2)
                                )
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    private func loadSlots() async {
        await viewModel.loadSlots(type: viewModel.appointmentType == .onlineConsultation ? "online" : "offline")
        isLoading = false
    }
    
    private func getVisibleDays() -> [String] {
        let days = Array(viewModel.slotsByDay.keys.sorted())
        if showMoreWasPressed {
            return days
        } else {
            return Array(days.prefix(2))
        }
    }
}

struct SlotView: View {
    @EnvironmentObject var viewModel: AppointmentViewModel
    
    var id: Int
    var date: String
    var time: String
    var price: Int
    
    private var isSelected: Bool {
        viewModel.selectedSlotId == id
    }
    
    var body: some View {
        Button {
            withAnimation(.snappy) {
                viewModel.selectedSlotId = id
                viewModel.selectedSlotDate = date
                viewModel.selectedSlotTime = time
                viewModel.selectedSlotPrice = price
            }
        } label: {
            VStack {
                Text(time)
                    .font(.onestRegular(size: 20))
                    .foregroundStyle(isSelected ? .white : .black)
                Text("\(price)₸")
                    .font(.onestLight(size: 16))
                    .foregroundStyle(isSelected ? Color.customGray : Color.dayTextGray)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(isSelected ? Color.customBlue : Color.customGray)
            .cornerRadius(16)
        }
    }
}
