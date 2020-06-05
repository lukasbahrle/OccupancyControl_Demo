//
//  AppCoordinator.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 31/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class AppFlowCoordinator{
    
    typealias DependencyProvider = HomeFlowCoordinatorDependencyProvider
    
    private let dependencyProvider: DependencyProvider
    private let window: UIWindow
    
    init(window: UIWindow, dependencyProvider: DependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start(){
        window.rootViewController = UIHostingController(rootView: dependencyProvider.homeView())
    }
}
