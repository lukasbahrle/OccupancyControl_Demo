//
//  TitleView.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    var isIn: Bool
    
    var body: some View {
        Text("Occupany Control")
        .font(.largeTitle)
        .fontWeight(.bold)
        .scaleEffect(self.isIn ? 1.0 : 0.5)
        .padding(.top, self.isIn ? 0 : 0)
    }
}
