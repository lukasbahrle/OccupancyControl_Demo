//
//  HistoryData.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 30/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation


enum HistoryDataType: Int, CaseIterable{
    case today
    case lastHour
    case lastThreeHours
    
    var label:String{
        switch self {
        case .today:
            return "Today"
         case .lastHour:
             return "Last Hour"
        case .lastThreeHours:
            return "Last 3 Hours"
        }
    }
}


struct HistoryData{
    let data: [HistoryDataType: [Int]]
}
