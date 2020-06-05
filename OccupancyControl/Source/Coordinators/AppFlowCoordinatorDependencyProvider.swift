//
//  AppFlowCoordinatorDependencyProvider.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 31/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import SwiftUI

protocol HomeFlowCoordinatorDependencyProvider: class {
    func homeView() -> AnyView
}
