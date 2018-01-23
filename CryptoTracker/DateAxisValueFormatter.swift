import Charts

class DateAxisValueFormatter: NSObject, IAxisValueFormatter {
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "GMT")
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter
    }()
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value)
        return dateFormatter.string(from: date
        )
    }
}
