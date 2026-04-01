import SwiftUI

struct CoinDetailView: View {
    let coin: Coin
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: coin.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .shadow(radius: 10)
                
                Text(coin.name)
                    .font(.largeTitle)
                    .bold()
                
                Text(coin.symbol.uppercased())
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 14) {
                    DetailRow(title: "Current Price", value: "$\(coin.currentPrice)")
                    
                    if let priceChange = coin.priceChangePercentage24H {
                        DetailRow(title: "24h Change", value: String(format: "%.2f%%", priceChange))
                    }
                    
                    if let marketCap = coin.marketCap {
                        DetailRow(title: "Market Cap", value: "$\(Int(marketCap))")
                    }
                    
                    if let rank = coin.marketCapRank {
                        DetailRow(title: "Rank", value: "#\(rank)")
                    }
                    
                    if let totalVolume = coin.totalVolume {
                        DetailRow(title: "Volume", value: "$\(Int(totalVolume))")
                    }
                    
                    if let high = coin.high24H {
                        DetailRow(title: "24H High", value: "$\(high)")
                    }
                    
                    if let low = coin.low24H {
                        DetailRow(title: "24H Low", value: "$\(low)")
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .navigationTitle(coin.symbol.uppercased())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.toggleFavorite(coinId: coin.id)
                }) {
                    Image(systemName: viewModel.savedFavoriteCoinIds.contains(coin.id) ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .bold()
        }
    }
}
