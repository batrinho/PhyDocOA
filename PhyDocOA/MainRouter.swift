//
//  AppCoordinator.swift
//  PhyDocOA
//
//  Created by Batyr Tolkynbayev on 12.12.2024.
//

import UIKit
import SwiftUI

protocol MainRouterProtocol: AnyObject {
    func start()
}

final class MainRouter: NSObject, MainRouterProtocol {
    private var nvc = UINavigationController()
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        window.makeKeyAndVisible()
    }
    
    func start() {
        let vc = RootView { [weak self] in
            guard let self else { return }
            self.startAppointmentFlow()
        }.wrapped
        nvc.isNavigationBarHidden = true
        nvc.pushViewController(vc, animated: false)
        self.window.rootViewController = nvc
    }
    
    private func startAppointmentFlow() {
        let vc = AppointmentView(
            startOver: { [weak self] in
                guard let self else { return }
                self.start()
            }, completion: { [weak self] in
                guard let self else { return }
                let vc = AppointmentDoneView(start: self.start).wrapped
                self.nvc.pushViewController(vc, animated: true)
            }
        ).wrapped
        nvc.pushViewController(vc, animated: true)
    }
}

