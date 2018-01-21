import Foundation

class CryptoCompareClient {
    
    let session = URLSession(configuration: .default)
    
    private func url(for currency: CryptoCurrency, from startDate: Date, to endDate: Date) -> URL {
        
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
        
        let task = session.dataTask(with: url(for: currency, from: startDate,  to: endDate)) { data, _ , _ in
            
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
