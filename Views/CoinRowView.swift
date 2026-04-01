import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let isFavorite: Bool
    
    var body: some View {
        HStack {
            Text("\(coin.marketCapRank ?? 0)")
                .font(.caption)
                .foregroundColor(.gray)
                .frame(minWidth: 30)
            
            AsyncImage(url: URL(string: coin.image)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Circle().fill(Color.gray.opacity(0.3))
            }
            .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(coin.symbol.uppercased())
                    .font(.headline)
                Text(coin.name)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 6)
            
            if isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("$\(coin.currentPrice, specifier: "%.2f")")
                    .bold()
                
                Text(String(format: "%.2f%%", coin.priceChangePercentage24H ?? 0))
                    .foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}
