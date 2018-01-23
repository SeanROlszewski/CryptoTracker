import Charts
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    func fetchDataForChart() {
        
    }
}
