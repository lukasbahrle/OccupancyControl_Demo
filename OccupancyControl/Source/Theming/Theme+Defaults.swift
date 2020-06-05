//
//  Theme+Defaults.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI

public extension Theme{
    static func defaultTheme() -> Theme{
        return Theme(
            tintColor: Color(UIColor.systemIndigo),
            backgroundColor: Color(.systemBackground),
            countLineWidth: 22,
            chartLineWidth:  3
        )
    }
}
