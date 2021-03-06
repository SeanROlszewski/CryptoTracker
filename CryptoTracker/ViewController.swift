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
        
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.chartDescription?.text = "The closing price of XRP for the past 30 days"

        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = .black
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = false
        xAxis.granularityEnabled = false
        xAxis.valueFormatter = DateAxisValueFormatter()
        
        let yAxis = lineChartView.leftAxis
        yAxis.drawGridLinesEnabled = false
        yAxis.drawLabelsEnabled = true
        yAxis.granularityEnabled = false
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 4
        yAxis.yOffset = 0
        yAxis.labelTextColor = .black
        
        lineChartView.animate(xAxisDuration: 2.5)
    }
    
}

extension ViewController {
    
    func fetchDataForChart() {
        let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: todaysDate)!
        
        cryptoCompareClient.getHistoricalData(forCurrency: .xrp,
                                              from: thirtyDaysAgo,
                                              to: todaysDate) { response in
                    self.handle(response)
        }
    }
    
    private func handle(_ response: CryptoCompareResponse) {
        
        let entries = chartData(fromDailyData: response.data)
        let historicalDataSet = prepareChartData(from: entries)
        
        DispatchQueue.main.async {
            let data = LineChartData(dataSet: historicalDataSet)
            self.lineChartView.data = data
        }
    }
    
    func chartData(fromDailyData data: [DailyHistoricalData]) -> [ChartDataEntry] {
        return data.map { datum in
            ChartDataEntry(x: datum.time, y: datum.closingPrice)
        }
    }
    
    private func prepareChartData(from dataEntries: [ChartDataEntry]) -> LineChartDataSet {
        let dataSet = LineChartDataSet(values: dataEntries, label: nil)
        dataSet.axisDependency = .left
        dataSet.circleRadius = 0
        dataSet.label = ""
        dataSet.drawValuesEnabled = false
        dataSet.cubicIntensity = 1
        dataSet.setColor(.black)
        return dataSet
    }
}
