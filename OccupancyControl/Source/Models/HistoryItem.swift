//
//  HistoryItem.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation


// History graph item. For example values for the `today` graph
struct HistoryItem{
    let label: String
    let values: [Int]
    
    var mostRecentValue: Int {
        values.count > 0 ? values[values.count - 1] : -1
    }
}
