//
//  HomeViewModel.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 30/05/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject{
    let useCase: HomeUseCaseType
    
    @Published var history: [HistoryItemViewModel] = [HistoryItemViewModel]();
    @Published var currentCount: Int = 0
    @Published var maxCount = 80
    
    private var dataSubscriber: AnyCancellable?
    
    init(useCase: HomeUseCaseType) {
        self.useCase = useCase
        getOccupancyData()
    }
    
    func getOccupancyData(){
        dataSubscriber = useCase.getOccupancyData()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (completion) in
                print(completion)
            }, receiveValue: { (data) in
                self.currentCount = data.current
                self.maxCount = data.max
                
                var history: [HistoryItemViewModel] = []
                
                for key in HistoryDataType.allCases{
                    guard let values = data.history.data[key] else {
                        continue
                    }
                    
                    history.append(HistoryItemViewModel(label: key.label, values: values))
                }
                
                self.history = history
            })
    }
    
    
}


