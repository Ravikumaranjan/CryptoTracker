import Foundation

class CoinDataService {
    // Uses modern Swift async/await for network calls
    func fetchCoins() async throws -> [Coin] {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=false") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // Decoding JSON payload into the Swift Codable model
        let coins = try JSONDecoder().decode([Coin].self, from: data)
        return coins
    }
}
