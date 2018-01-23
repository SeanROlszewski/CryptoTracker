import XCTest
@testable import CryptoTracker

class DateAxisValueFormatterTests: XCTestCase {
    
    
    func test_dateFormatting() {
        let axisValueFormatter = DateAxisValueFormatter()
        
        let date1 = DateComponents(calendar: .current,
                                       timeZone: TimeZone(identifier: "GMT"),
                                       year: 2017,
                                       month: 12,
                                       day: 1).date!.timeIntervalSince1970
        
        let date2 = DateComponents(calendar: .current,
                                   timeZone: TimeZone(identifier: "GMT"),
                                   year: 2015,
                                   month: 06,
                                   day: 29).date!.timeIntervalSince1970
        
        let value1 = axisValueFormatter.stringForValue(date1, axis: nil)
        let value2 = axisValueFormatter.stringForValue(date2, axis: nil)

        XCTAssertEqual("12/01/17", value1)
        XCTAssertEqual("06/29/15", value2)

        
    }
}
