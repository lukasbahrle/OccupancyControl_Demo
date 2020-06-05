//
//  Theme.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI

public class Theme: ObservableObject{
    @Published var tintColor: Color
    @Published var backgroundColor: Color
    @Published var countLineWidth: CGFloat
    @Published var chartLineWidth: CGFloat
    
    init(tintColor: Color, backgroundColor: Color, countLineWidth: CGFloat, chartLineWidth: CGFloat){
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.chartLineWidth = chartLineWidth
        self.countLineWidth = countLineWidth
    }
}
