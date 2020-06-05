//
//  OccupancyData.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 02/06/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation

struct OccupancyData{
    let current: Int
    let max: Int
    let history: HistoryData
}

extension OccupancyData{
    static func emptyData() -> Self{
        return OccupancyData(current: 0, max: 0, history: HistoryData(data: [:]))
    }
    
    func isEmpty() -> Bool{
        history.data.count == 0
    }
}
