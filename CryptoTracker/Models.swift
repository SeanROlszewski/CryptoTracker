import Foundation

enum CryptoCurrency: String {
    case xrp = "XRP"
}

struct DailyHistoricalData: Codable {
    let time: Double
    let closingPrice: Double
    let openingPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let volumeFrom: Double
    let volumeTo: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "time"
        case closingPrice = "close"
        case openingPrice = "open"
        case highPrice = "high"
        case lowPrice = "low"
        case volumeFrom = "volumefrom"
        case volumeTo = "volumeto"
    }
}

struct CryptoCompareResponse: Codable {
    let data: [DailyHistoricalData] 
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
    
}
