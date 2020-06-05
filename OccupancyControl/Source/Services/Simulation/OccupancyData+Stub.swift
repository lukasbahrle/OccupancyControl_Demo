//
//  OccupancyData+Stub.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 04/06/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation


extension OccupancyData{
    static func stub() -> OccupancyData{
        return OccupancyData(current: 62, max: 80, history: HistoryData(data: [
        .today: [0, 4, 3, 5, 8, 9, 10, 22, 41, 53, 62, 76, 79, 79, 62, 45, 23, 15, 8, 9, 10, 22, 41, 53, 56, 46, 62],
        .lastHour:  [36, 40, 49, 50, 51, 54, 52, 49, 44, 47, 50, 48, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 57, 58, 61, 62],
        .lastThreeHours : [7, 4, 11, 15, 17, 21, 24, 26, 34, 41, 48, 51, 56, 48, 44, 34, 28, 31, 39, 36, 32, 36, 41, 47, 52, 58, 62]
        ]))
    }
}
