import XCTest
import UIKit
@testable import CryptoTracker

class MockCryptoCompareClient: CryptoCompareIntegration {
    
    private(set) var methodCalls: [String] = []
    
    func getHistoricalData(forCurrency currency: CryptoCurrency, from startDate: Date, to endDate: Date, using completionHandler: @escaping (CryptoCompareResponse) -> ()) {
        methodCalls.append(#function)
        let testData = [DailyHistoricalData(time: 0, closingPrice: 0, openingPrice: 0, highPrice: 0, lowPrice: 0, volumeFrom: 0, volumeTo: 0)]
        completionHandler(CryptoCompareResponse(data: testData))
    }
    
    
}

class ViewControllerTests: XCTestCase {
    
    
    func testExample() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        
        
//        roomhartView.delegate)
    }
}
