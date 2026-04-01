import Foundation

@MainActor
class HomeViewModel: ObservableObject {
    @Published var coins: [Coin] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var searchText: String = ""
    @Published var savedFavoriteCoinIds: Set<String> = []
    private let favoritesKey = "saved_favorites"
    
    var filteredCoins: [Coin] {
        if searchText.isEmpty {
            return coins
        } else {
            return coins.filter { coin in
                coin.name.localizedCaseInsensitiveContains(searchText) ||
                coin.symbol.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    private let dataService = CoinDataService()
    
    init() {
        loadFavorites()
        // Kick off networking operation when initialized
        Task {
            await loadCoins()
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.array(forKey: favoritesKey) as? [String] {
            savedFavoriteCoinIds = Set(savedData)
        }
    }
    
    func toggleFavorite(coinId: String) {
        if savedFavoriteCoinIds.contains(coinId) {
            savedFavoriteCoinIds.remove(coinId)
        } else {
            savedFavoriteCoinIds.insert(coinId)
        }
        UserDefaults.standard.set(Array(savedFavoriteCoinIds), forKey: favoritesKey)
    }
    
    func loadCoins() async {
        isLoading = true
        errorMessage = nil
        do {
            coins = try await dataService.fetchCoins()
        } catch {
            errorMessage = "Failed to fetch data: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
