//
//  ContentView.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 28/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var theme: Theme
    
    private var isIn: Bool {
        viewModel.history.count > 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: self.isIn ? 20 : 0){
                Spacer().frame(height: self.isIn ? 20 : max(10, geometry.size.height * 0.5 - 60))
                
                // Title
                TitleView(isIn: self.isIn)
                    .animation(.spring())
                
                // Current %
                CurrentCountView(isIn: self.isIn, frameHeight: (geometry.size.height * 0.32) , current: self.viewModel.currentCount, max: self.viewModel.maxCount)
                    .padding(.top, self.isIn ? geometry.size.height * 0.07 : 0)
                .animation(.spring())
                
                // Graphs
                HistoryView(max: self.viewModel.maxCount, data: self.viewModel.history, isIn: self.isIn)
                    .padding(.top, self.isIn ? geometry.size.height * 0.05 : 0)
                    .animation(.spring())
                
                Spacer()
                
            }
            .background(self.theme.backgroundColor)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppFactory().homeView()
        .darkModeFix()
        .environment(\.colorScheme, .dark)
        .environmentObject(Theme.defaultTheme())
    }
}





