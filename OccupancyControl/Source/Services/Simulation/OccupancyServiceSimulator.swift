//
//  OccupancyServiceSimulator.swift
//  OccupancyControl
//
//  Created by Lukas Bahrle Santana on 01/06/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import Foundation
import Combine


class OccupancyServiceSimulator: OccupancyServiceType{
    private var dataSubject = CurrentValueSubject<OccupancyData, Error>(OccupancyData.emptyData())
    private var timeStamp: Double = 0;
    
    private var initialData = OccupancyData.stub()
    
    // stops the simulation after `stopSimulationTime` seconds
    private var stopSimulationTime: Double = 15
    private var isSimulationStopped = false
    private var loopSimulation = true
    
    // load initial data and return data publisher
    func getOccupancyData() -> AnyPublisher<OccupancyData, Error> {
        if(dataSubject.value.isEmpty()){loadData()}
        return dataSubject.eraseToAnyPublisher()
    }
    
    
    // simulate initial data loading
    private func loadData(){
        //reset
        isSimulationStopped = false
        timeStamp = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dataSubject.send(self.initialData)
        }
        
        if stopSimulationTime > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + stopSimulationTime) {
                self.stopSimulation()
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.updateData()
        }
    }
    
    
    // add some random values to the data and publish
    func updateData(){
        guard !isSimulationStopped && !dataSubject.value.isEmpty() else {return}
        
        let maxValue = dataSubject.value.max
        let history = dataSubject.value.history
        
        var todayData = history.data[.today]!
        var lastHourData = history.data[.lastHour]!
        var lastThreeHoursData = history.data[.lastThreeHours]!
        
        var randomValues = [Int]()
        let countNewValues = 5
        for _ in 0 ..< countNewValues {
            let value =  min(maxValue, max(0, Int.random(in: -5 ... 5) + initialData.current - Int(sin(timeStamp) * 20)))
            randomValues.append(value)
            timeStamp += 0.05
        }
        
        let currentNext = randomValues.last ?? 0
        lastHourData.removeFirst(countNewValues)
        lastHourData.append(contentsOf: randomValues)
        
        let countNewThreeHoursValues = 2
        lastThreeHoursData.removeFirst(countNewThreeHoursValues)
        lastThreeHoursData.append(contentsOf: randomValues[randomValues.count - countNewThreeHoursValues ... randomValues.count - 1 ])
        
        todayData.remove(at: 0)
        todayData.append(currentNext)
        
        timeStamp += 0.15
       
        let nextOccupancyData = OccupancyData(current: currentNext, max: maxValue, history: HistoryData(data: [
            .today: todayData,
            .lastHour: lastHourData,
            .lastThreeHours: lastThreeHoursData
        ]))
        
        dataSubject.send(nextOccupancyData)
        
        // schedule new update
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.updateData()
        }
    }
    
    
    private func stopSimulation(){
        isSimulationStopped = true
        dataSubject.send(OccupancyData.emptyData())
        
        if loopSimulation{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loadData()
            }
        }
    }
    
    
}
