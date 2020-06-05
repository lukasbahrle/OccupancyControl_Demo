//
//  HomeViewModelTests.swift
//  OccupancyControlTests
//
//  Created by Lukas Bahrle Santana on 04/06/2020.
//  Copyright © 2020 Lukas Bahrle Santana. All rights reserved.
//

import XCTest
@testable import OccupancyControl
import Combine

class HomeViewModelTests: XCTestCase {
    
    var useCase: StubHomeUseCase!
    var viewModel: HomeViewModel!

    override func setUp() {
        self.useCase = StubHomeUseCase()
        self.viewModel = HomeViewModel(useCase: self.useCase)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testData(){
        
        XCTAssertEqual(useCase.countGetOccupancyData, 1)
        XCTAssertEqual(viewModel.history.count, 0)
        
        let occupancyData = OccupancyData(current: 23, max: 100, history: HistoryData(data: [
            HistoryDataType.today: [0,3,4,5,10,5,3,4,2,2],
            HistoryDataType.lastHour: [0,1,2,3,4,5,6,4,3,2]
        ]))
        
        useCase.testData(data: occupancyData)
        
        let expectation = XCTestExpectation(description: "Data received and parsed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            
            XCTAssertEqual(self?.viewModel.currentCount, 23)
            XCTAssertEqual(self?.viewModel.maxCount, 100)
            XCTAssertEqual(self?.viewModel.history.count, 2)
            XCTAssertEqual(self?.viewModel.history[0].label, HistoryDataType.today.label)
            XCTAssertEqual(self?.viewModel.history[1].label, HistoryDataType.lastHour.label)
            XCTAssertEqual(self?.viewModel.history[0].values.count, 10)
            XCTAssertEqual(self?.viewModel.history[0].values[1], 3)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
    }

}




class StubHomeUseCase: HomeUseCaseType{
    
    private var occupancySubject = PassthroughSubject<OccupancyData, Error>()
    private(set) var countGetOccupancyData: Int = 0
    
    func getOccupancyData() -> AnyPublisher<OccupancyData, Error> {
        countGetOccupancyData += 1
        return occupancySubject.eraseToAnyPublisher()
    }
    
    func testData(data: OccupancyData = OccupancyData.stub()){
        print("send: \(data)")
        occupancySubject.send(data)
    }
    
}
