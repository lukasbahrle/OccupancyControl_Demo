//
//  OccupancyService.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 30/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import Combine


protocol OccupancyServiceType{
    func getOccupancyData() -> AnyPublisher<OccupancyData, Error>
}


// TODO: access to the occupancy data repository and fetch the data
class OccupancyService: OccupancyServiceType{
    private var dataSubject = CurrentValueSubject<OccupancyData, Error>(OccupancyData.emptyData())
    
    func getOccupancyData() -> AnyPublisher<OccupancyData, Error> {
        return dataSubject.eraseToAnyPublisher()
    }
}
