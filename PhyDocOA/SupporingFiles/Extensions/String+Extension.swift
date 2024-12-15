//
//  String+Extension.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 15.12.2024.
//

import Foundation

extension String {
    func beforeComma() -> String {
        if let commaIndex = self.firstIndex(of: ",") {
            return String(self[..<commaIndex])
        }
        return self
    }
}
