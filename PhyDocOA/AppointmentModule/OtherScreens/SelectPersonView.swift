//
//  SelectPersonView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

enum Tab: String, Identifiable, CaseIterable {
    var id: String { self.rawValue }

    case myself = "Себя"
    case other = "Другого"
}

struct SelectPersonView: View {
    @EnvironmentObject var viewModel: AppointmentViewModel
    @State private var activeTab: Tab = .myself

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            TitleView(title: viewModel.titleForCurrentStep())

            VStack(alignment: .leading, spacing: 20) {
                tabBar()
                TabView(selection: $activeTab) {
                    myselfDetailsView()
                        .tag(Tab.myself)
                    newPersonDetailsView()
                        .tag(Tab.other)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }

    @ViewBuilder
    private func tabBar() -> some View {
        GeometryReader { geometry in
            HStack(spacing: 16) {
                ForEach(Tab.allCases) { tab in
                    tabItem(for: tab)
                }
            }
            .padding(.horizontal, 7)
            .frame(maxWidth: .infinity, minHeight: 58, maxHeight: 58)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 1)
            )
            .cornerRadius(12)
            .background(
                ZStack(alignment: .leading) {
                    if let index = Tab.allCases.firstIndex(of: activeTab) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.customBlue)
                            .frame(width: (geometry.size.width / CGFloat(Tab.allCases.count) - 14), height: 44)
                            .offset(x: CGFloat(Double(index) - 0.5) * (geometry.size.width / CGFloat(Tab.allCases.count)))
                            .animation(.snappy, value: activeTab)
                    }
                }
            )
        }
        .frame(height: 58)
    }

    @ViewBuilder
    private func myselfDetailsView() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                selfDetailField(for: "Имя и фамилия:", string: "Иванов Иван")
                selfDetailField(for: "ИИН:", string: "041115486195")
                selfDetailField(for: "Номер телефона:", string: "+7 707 748 4815")
                selfDetailField(for: "Адрес прописки:", string: "+7 707 748 4815")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollIndicators(.hidden)
    }

    @ViewBuilder
    private func newPersonDetailsView() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                detailTextField(for: "Имя и фамилия", placeholderTitle: "Введите фио", string: $viewModel.name)
                detailTextField(for: "ИИН", placeholderTitle: "Введите ИИН человека", string: $viewModel.iin)
                detailTextField(for: "Номер телефона", placeholderTitle: "Введите номер телефона", string: $viewModel.phoneNumber)
                detailTextField(for: "Адрес", placeholderTitle: "Адрес прописки", string: $viewModel.address)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func tabItem(for tab: Tab) -> some View {
        Button {
            withAnimation(.snappy) {
                activeTab = tab
            }
        } label: {
            Text(tab.rawValue)
                .font(.onestBold(size: 16))
                .foregroundStyle(tab == activeTab ? .white : .black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
    }

    @ViewBuilder
    private func selfDetailField(for title: String, string: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.onestLight(size: 16))
                .foregroundColor(.gray)
            Text(string)
                .font(.onestLight(size: 18))
        }
    }

    @ViewBuilder
    private func detailTextField(for title: String, placeholderTitle: String, string: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.onestLight(size: 16))
            
            TextField("", text: string, prompt: Text(placeholderTitle).font(.onestLight(size: 16)))
                .padding(8)
                .frame(maxWidth: .infinity, minHeight: 56, maxHeight: 56)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray, lineWidth: 1)
                )
                .cornerRadius(12)
        }
    }
}

