import XCTest
import UIKit
@testable import CryptoTracker

class MockCryptoCompareClient: CryptoCompareIntegration {
    
    private(set) var methodCalls: [String] = []
    private(set) var lastStartDate: Date?
    private(set) var lastEndDate: Date?
    private(set) var lastCurrency: CryptoCurrency?
    
    
    func getHistoricalData(forCurrency currency: CryptoCurrency,
                           from startDate: Date,
                           to endDate: Date,
                           using completionHandler: @escaping (CryptoCompareResponse) -> ()) {
        lastCurrency = currency
        lastStartDate = startDate
        lastEndDate = endDate
        methodCalls.append(#function)
        
        let testData = [DailyHistoricalData(time: 0, closingPrice: 0)]
        completionHandler(CryptoCompareResponse(data: testData))
    }
}

class ViewControllerTests: XCTestCase {
    
    let startDate = DateComponents(calendar: .current,
                                   timeZone: TimeZone(identifier: "GMT"),
                                   year: 2017,
                                   month: 12,
                                   day: 31).date!
    
    let endDate = DateComponents(calendar: .current,
                                 timeZone: TimeZone(identifier: "GMT"),
                                 year: 2017,
                                 month: 12,
                                 day: 1).date!
    var viewController: ViewController!
    var mockClient: MockCryptoCompareClient!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mockClient = MockCryptoCompareClient()
        viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.cryptoCompareClient = mockClient
        viewController.todaysDate = startDate
        viewController.view.layoutIfNeeded()
    }
    
    func test_viewController_getsPricesAfterViewLoads() {
        
        XCTAssertEqual(mockClient.lastCurrency, .xrp)
        XCTAssertEqual(mockClient.lastStartDate, startDate)
        XCTAssertEqual(mockClient.lastEndDate, endDate)
        
        XCTAssertEqual(mockClient.methodCalls, ["getHistoricalData(forCurrency:from:to:using:)"])
    }
    
    func test_viewController_mapsDailyDataToChartData() {
        let inputData = [DailyHistoricalData(time: 100, closingPrice: 5000),
                         DailyHistoricalData(time: 200, closingPrice: 1)]
        let results = viewController.chartData(fromDailyData: inputData)
//        let expectedResults = []
//        XCTAssertEqual(results, )
    }
}
