import Foundation
protocol CryptoCompareIntegration {
    func getHistoricalData(forCurrency currency: CryptoCurrency,
    from startDate: Date,
    to endDate: Date,
    using completionHandler: @escaping (CryptoCompareResponse)->())
}

class CryptoCompareClient: CryptoCompareIntegration {
    
    let session = URLSession(configuration: .default)
    
    func dailyHistoricalDataUrl(for currency: CryptoCurrency, from startDate: Date, to endDate: Date) -> URL {
        
        return URL(string:"")!
    }
    
    func getHistoricalData(forCurrency currency: CryptoCurrency,
                           from startDate: Date,
                           to endDate: Date,
                           using completionHandler: @escaping (CryptoCompareResponse)->()) {
        
    }
}
