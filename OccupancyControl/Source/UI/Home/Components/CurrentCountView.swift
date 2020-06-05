//
//  CurrentCountView.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI

struct CurrentCountView: View{
    @EnvironmentObject var theme: Theme
    
    var isIn:Bool
    var frameHeight: CGFloat
    var current: Int
    var max: Int
    var percent: CGFloat {
        max > 0 ? CGFloat(current) / CGFloat(max) : 0
    }
    
    var body: some View {
         GeometryReader { geometry in
        VStack(spacing: self.isIn ? 20 : 0){
            // % value
            VStack(spacing: self.isIn ? 4 : 0){
                HStack(spacing: 4){
                    Text("\(Int(self.percent * 100))")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("%")
                    .fontWeight(.heavy)
                    .offset(x: 0, y: 4)
                }
                .frame(width: geometry.size.width)
                .foregroundColor(Color(.label))
                .animation(nil)
            }
            .frame(height: self.frameHeight - 50)
            .overlay(
                 // circles
                ZStack {
                    Circle()
                        .stroke(lineWidth: self.theme.countLineWidth)//
                        .foregroundColor(Color(.systemGray4))
                    
                    Circle()
                        .trim(from: 0.0, to: self.percent)
                        .stroke(style: StrokeStyle(lineWidth: self.theme.countLineWidth, lineCap: .round, lineJoin: .miter))
                        .foregroundColor(self.theme.tintColor)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.spring())
                }
            )
           
            // current count text
            VStack(spacing: self.isIn ? 4 : 0){
                Text("Live data")
                Text(" Currently \(self.current) of \(self.max) ")
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray))
                .animation(nil)
            }
            .frame(height: 50)
        }
        .opacity(self.isIn ? 1.0 : 0)
        }
        .frame(height: self.isIn ? 240 : 0)
    }
}

struct CurrentCountView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentCountView(isIn: true, frameHeight: 100, current: 65, max: 100)
        .darkModeFix()
               .environment(\.colorScheme, .dark)
                   .previewDevice("iPhone 8 Plus")
               .environmentObject(Theme.defaultTheme())
    }
}
