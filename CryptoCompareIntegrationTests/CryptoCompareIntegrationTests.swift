import XCTest
import Foundation
@testable import CryptoTracker

class CryptoCompareClientTests: XCTestCase {
    let startDate = DateComponents(calendar: .current,
                                   timeZone: TimeZone(identifier: "GMT"),
                                   year: 2017,
                                   month: 12,
                                   day: 1).date!
    
    let endDate = DateComponents(calendar: .current,
                                 timeZone: TimeZone(identifier: "GMT"),
                                 year: 2017,
                                 month: 12,
                                 day: 3).date!
    
    func test_urlBuilder() {
        let client = CryptoCompareClient()
        let url = client.dailyHistoricalDataUrl(for: .xrp, from: startDate, to: endDate)
        XCTAssertEqual(url.absoluteString, """
        https://min-api.cryptocompare.com/data/histoday?fsym=XRP&tsym=USD&limit=2&aggregate=1&toTs=1512259200&extraParams=CryptoTracker
        """)
    }
    
    func test_retrievingHistoricalData() {
        let retrievalExpectation = expectation(description: "retrieves historical data from CryptoCompare for a given crypto currency")
        
        let client = CryptoCompareClient()
        
        let startDate = DateComponents(calendar: .current,
                                       timeZone: TimeZone(identifier: "GMT"),
                                       year: 2017,
                                       month: 12,
                                       day: 1).date!
        
        let endDate = DateComponents(calendar: .current,
                                     timeZone: TimeZone(identifier: "GMT"),
                                     year: 2017,
                                     month: 12,
                                     day: 3).date!
        
        client.getHistoricalData(forCurrency: .xrp,
                                 from: startDate,
                                 to: endDate) { response in
                                    
                                    guard response.data.count == 3 else {
                                        XCTFail("Expected there to be 3 data points, but got \(response.data.count)")
                                        return
                                    }
                                    
                                    XCTAssertEqual(startDate.timeIntervalSince1970,
                                                   response.data[0].time)
//                                    
                                    XCTAssertEqual(endDate.timeIntervalSince1970,
                                                   response.data[2].time)
                                    
                                    retrievalExpectation.fulfill()
        }
        
        wait(for: [retrievalExpectation], timeout: 5.0)
        
    }
}


