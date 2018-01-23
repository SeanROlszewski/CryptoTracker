import Foundation

enum CryptoCurrency: String {
    case xrp = "XRP"
}

struct DailyHistoricalData: Codable {
    let time: Double
    let closingPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case closingPrice = "close"
    }
}

struct CryptoCompareResponse: Codable {
    let data: [DailyHistoricalData] 
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }    
}
