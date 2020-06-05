//
//  HomeUseCase.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 30/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import Combine


protocol HomeUseCaseType {
    func getOccupancyData() -> AnyPublisher<OccupancyData, Error>
}


final class HomeUseCase: HomeUseCaseType{
    
    private let occupancyService: OccupancyServiceType
    
    init(occupancyService: OccupancyServiceType) {
        self.occupancyService = occupancyService
    }
    
    func getOccupancyData() -> AnyPublisher<OccupancyData, Error> {
        occupancyService.getOccupancyData()
    }
    
}
