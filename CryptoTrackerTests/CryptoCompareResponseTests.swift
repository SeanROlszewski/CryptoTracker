import XCTest
@testable import CryptoTracker
import Foundation

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
        
        XCTAssertEqual(response.data[1].time, 1516060800)
        XCTAssertEqual(response.data[2].time, 1516320000)
    }
}

