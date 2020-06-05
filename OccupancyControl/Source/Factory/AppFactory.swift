//
//  AppFactory.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 31/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import SwiftUI

final class AppFactory {
    
   private let servicesProvider: ServicesProvider
   private let theme: Theme
    
    init(servicesProvider: ServicesProvider = ServicesProvider.defaultProvider(), theme: Theme = Theme.defaultTheme()) {
       self.servicesProvider = servicesProvider
       self.theme = theme
   }
}


extension AppFactory: HomeFlowCoordinatorDependencyProvider {
    func homeView() -> AnyView{
        let homeUseCase = HomeUseCase(occupancyService: servicesProvider.occupancy)
        let viewModel = HomeViewModel(useCase: homeUseCase)
        return AnyView(HomeView(viewModel :viewModel).environmentObject(theme))
    }
}
