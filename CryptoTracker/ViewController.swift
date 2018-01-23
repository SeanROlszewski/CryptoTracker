import Charts
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    lazy var cryptoCompareClient: CryptoCompareIntegration = CryptoCompareClient()
    lazy var todaysDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataForChart()
        configureChartView()
    }
    
    func configureChartView() {
//        lineChartView.lineData = LineChartData(dataSet: <#T##IChartDataSet?#>)
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .topInside
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
//        xAxis.valueFormatter = DateValueFormatter()
        
        let yAxis = lineChartView.leftAxis
        yAxis.labelPosition = .insideChart
        yAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        yAxis.drawGridLinesEnabled = true
        yAxis.granularityEnabled = true
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 170
        yAxis.yOffset = -9
        yAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        
        
    }

}

extension ViewController {
    
    func chartData(fromDailyData data: [DailyHistoricalData]) -> [ChartData] {
        return []
    }
    
    func fetchDataForChart() {
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: todaysDate)!
        
        cryptoCompareClient.getHistoricalData(forCurrency: .xrp,
        from: todaysDate, to: thirtyDaysAgo) { historicalData in
            
        }
    }
}
