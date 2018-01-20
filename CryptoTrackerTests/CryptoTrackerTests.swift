import XCTest
@testable import CryptoTracker
import Foundation

//https://min-api.cryptocompare.com/data/histoday?fsym=ETH&tsym=BTC&limit=60&aggregate=1&toTs=1516227914&extraParams=your_app_name

class CryptoCompareResponseTests: XCTestCase {
    func test_deserialization() {
        
        let path = Bundle(for: CryptoCompareResponseTests.self).path(forResource: "CryptoCompareResponse", ofType: "json")!
        let examplePayload = try! Data(contentsOf: URL(fileURLWithPath: path))
        
        
        guard let response = try? JSONDecoder().decode(CryptoCompareResponse.self, from: examplePayload) else {
            XCTFail("Was unable to decode the data from the payload")
            return
        }
        
        guard response.data.count == 3 else {
            XCTFail("Expected there to be 3 data points, but got \(response.data.count)")
            return
        }
        
        XCTAssertEqual(response.data[0].time, 1515801600)
        XCTAssertEqual(response.data[0].closingPrice, 1272.88, accuracy: 0.01)
        XCTAssertEqual(response.data[0].highPrice, 1404.95, accuracy: 0.01)
        XCTAssertEqual(response.data[0].lowPrice, 1193, accuracy: 0.01)
        XCTAssertEqual(response.data[0].openingPrice, 1193, accuracy: 0.01)
        XCTAssertEqual(response.data[0].volumeTo, 100109161.39, accuracy: 0.01)
        XCTAssertEqual(response.data[0].volumeFrom, 75445.22, accuracy: 0.01)

        XCTAssertEqual(response.data[1].time, 1516060800)
        XCTAssertEqual(response.data[2].time, 1516320000)
    }
}

enum CryptoCurrency {
    case xrp
}

class CryptoCompareClient {
    
    let session = URLSession(configuration: .default)
    
    private func url(for currency: CryptoCurrency, from startDate: Date, to endDate: Date) -> URL {
        return URL(string: "https://google.com")!
    }
    
    func getHistoricalData(forCurrency currency: CryptoCurrency, from startDate: Date,  to endDate: Date, using completionHandler: (CryptoCompareResponse)->()) {
        let task = session.dataTask(with: url(for: currency, from: startDate,  to: endDate))
        
    }
}

class CryptoCompareClientTests: XCTestCase {
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
                                    
                                    retrievalExpectation.fulfill()
        }
        
        wait(for: [retrievalExpectation], timeout: 5.0)
        
    }
    
}

