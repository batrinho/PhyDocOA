//
//  View+UIViewController.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import UIKit
import SwiftUI

public extension View {
    var wrapped: UIHostingController<Self> {
        UIHostingController(rootView: self)
    }
}
