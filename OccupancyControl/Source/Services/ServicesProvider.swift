//
//  ServicesProvider.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 31/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation

class ServicesProvider {
    let occupancy: OccupancyServiceType
    
    static func defaultProvider() -> ServicesProvider {
        let occupancy = OccupancyServiceSimulator()
        return ServicesProvider(occupancy: occupancy)
    }

    init(occupancy: OccupancyServiceType) {
        self.occupancy = occupancy
    }
}
