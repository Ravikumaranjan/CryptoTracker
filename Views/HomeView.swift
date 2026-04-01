import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading && viewModel.coins.isEmpty {
                    ProgressView("Fetching Coins...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                            .padding(.bottom, 8)
                        Text("Oops! Something went wrong.")
                            .font(.headline)
                        Text(errorMessage)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.secondary)
                        
                        Button("Try Again") {
                            Task { await viewModel.loadCoins() }
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    List(viewModel.filteredCoins) { coin in
                        NavigationLink(destination: CoinDetailView(coin: coin)) {
                            CoinRowView(coin: coin, isFavorite: viewModel.savedFavoriteCoinIds.contains(coin.id))
                        }
                    }
                    .listStyle(PlainListStyle())
                    .searchable(text: $viewModel.searchText, prompt: "Search coins")
                    .refreshable {
                        await viewModel.loadCoins()
                    }
                }
            }
            .navigationTitle("Crypto Tracker")
        }
    }
}
