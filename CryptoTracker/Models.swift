import Foundation

enum CryptoCurrency: String {
    case xrp = "XRP"
}

struct DailyHistoricalData: Codable {
    let time: Double
    let closingPrice: Double
}

struct CryptoCompareResponse: Codable {
    let data: [DailyHistoricalData] 
}
