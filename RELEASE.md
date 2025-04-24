# SFSymbolPicker 1.0.0

## 🎉 Initial Release

The first official release of SFSymbolPicker, a beautiful and intuitive SwiftUI component for picking SF Symbols in your iOS and macOS apps.

### ✨ Features

- Beautiful grid-based symbol picker interface
- Categorized symbol browsing
- Support for iOS and macOS
- Easy integration with SwiftUI
- Built with SwiftUI and native system components

### 📦 Installation

Add the package to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/wangqiyangX/SFSymbolPicker.git", from: "1.0.0")
]
```

### 🚀 Usage

Basic usage example:

```swift
import SwiftUI
import SFSymbolPicker

struct ContentView: View {
    @State private var selectedSymbol = "book"

    var body: some View {
        Form {
            SFSymbolPicker("Event icon", selection: $selectedSymbol)
        }
    }
}
```

### 📋 Requirements

- iOS 17.0+
- macOS 14.0+
- watchOS 10.0+
- Swift 6.1+
- Xcode 15.0+

### 🔗 Links

- [Documentation](https://github.com/wangqiyangX/SFSymbolPicker#readme)
- [Source Code](https://github.com/wangqiyangX/SFSymbolPicker)
- [Issues](https://github.com/wangqiyangX/SFSymbolPicker/issues)

### 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
