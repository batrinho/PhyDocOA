//
//  StepStatusView.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import SwiftUI

struct StepStatusView: View {
    var completion: () -> Void
    var stepNumber: Int
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                HStack(spacing: 10) {
                    ForEach(0..<3) { step in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 28, height: 6)
                            .foregroundColor(step <= stepNumber ? .customBlue : .customPurple)
                    }
                }
                Spacer()
            }
            
            HStack {
                Spacer()
                Button(action: completion) {
                    Image("xmark")
                }
            }
        }
    }
}
