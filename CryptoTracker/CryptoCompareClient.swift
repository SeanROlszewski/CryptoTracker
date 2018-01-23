import Foundation
protocol CryptoCompareIntegration {
    func getHistoricalData(forCurrency currency: CryptoCurrency,
    from startDate: Date,
    to endDate: Date,
    using completionHandler: @escaping (CryptoCompareResponse)->())
}
class CryptoCompareClient: CryptoCompareIntegration {
    
    let session = URLSession(configuration: .default)
    
    private func dailyHistoricalDataUrl(for currency: CryptoCurrency, from startDate: Date, to endDate: Date) -> URL {
        
        let numberOfDays = Calendar.current.dateComponents([.year, .month, .day], from: startDate, to: endDate).day!
        
        return URL(string:
            """
            https://min-api.cryptocompare.com/data/histoday?fsym=\(currency.rawValue)&tsym=USD&limit=\(numberOfDays)&aggregate=1&toTs=\(endDate.timeIntervalSince1970)&extraParams=CryptoTracker
            """
            )!
    }
    
    func getHistoricalData(forCurrency currency: CryptoCurrency,
                           from startDate: Date,
                           to endDate: Date,
                           using completionHandler: @escaping (CryptoCompareResponse)->()) {
        let url = dailyHistoricalDataUrl(for: currency, from: startDate,  to: endDate)
        let task = session.dataTask(with: url) { data, _, _ in
            
            guard let responseData = data,
                let dataPoints = try? JSONDecoder().decode(CryptoCompareResponse.self, from: responseData) else {
                    completionHandler(CryptoCompareResponse(data: []))
                    return
            }
            
            completionHandler(dataPoints)
            
        }
        
        task.resume()
        
    }
}
