# CryptoTracker

A modern iOS application built with SwiftUI that tracks real-time cryptocurrency prices, market caps, and volumetric data using the live CoinGecko API.

## Features

- **Live Market Data**: Fetches real-time cryptocurrency metrics (Price, 24h Change, Market Cap, Volume).
- **MVVM Architecture**: Clean separation of concerns between Models, Views, and ViewModels.
- **Modern Concurrency**: Built completely using Swift's `async/await` for safe, efficient network calls.
- **Declarative UI**: fluid and responsive user interface built 100% programmatically with SwiftUI.
- **Pull-to-Refresh**: Native refreshable list allowing users to fetch the latest market conditions.
- **Async Image Loading**: Efficiently loads and caches coin logos asynchronously.

## Technologies Used

- **Swift 5+**
- **SwiftUI**
- **URLSession** (REST API Networking)
- **JSONDecoder** (Data Parsing)

## Getting Started

1. Clone the repository to your local machine.
2. Open `CryptoTracker.xcodeproj` in Xcode 14.0 or newer.
3. Build and run the project using the iOS Simulator or a physical device (requires iOS 15.0+).

## API Integration

This app relies on the free tier of the [CoinGecko API](https://www.coingecko.com/en/api). No API keys are required to build and run this project out of the box.

## Future Roadmap

- [ ] Add Search Bar to filter through cryptocurrencies
- [ ] Implement local persistence (UserDefaults/CoreData) to save favorite coins
- [ ] Add historical price charts (Swift Charts)

## Developer

Developed by [Your Name] - Available for iOS Intern Roles.
