//
//  NetworkingService.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 14.12.2024.
//

import SwiftUI
import UIKit

struct Slot: Codable, Identifiable {
    let id: Int
    let datetime: String
    let price: Int
}

struct SlotResponse: Codable {
    var slots: [Slot]
}

final class NetworkingService {
    private let getScheduleURL = URL(string: "https://phydoc-test-2d45590c9688.herokuapp.com/get_schedule?type=online")!
    private let appointURL = URL(string: "https://phydoc-test-2d45590c9688.herokuapp.com/appoint")!
    
    // MARK: - GET Request
    func fetchSlots(type: String) async throws -> [Slot] {
        let (data, _) = try await URLSession.shared.data(from: getScheduleURL)
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(SlotResponse.self, from: data)
        
        return response.slots
    }
    
    // MARK: - Book Slot (POST Request)
    func bookSlot(slotID: Int, type: String) async throws -> Bool {
        let appointment = [
            "slot_id": slotID,
            "type": type
        ] as [String : Any]
        
        var request = URLRequest(url: appointURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: appointment, options: [])
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return true
    }
    
}
