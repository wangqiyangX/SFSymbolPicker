# SFSymbolPicker

A beautiful and intuitive SwiftUI component for picking SF Symbols in your iOS and macOS apps.

![SFSymbolPicker Preview](preview.png)

## Features

- 🎨 Beautiful grid-based symbol picker interface
- 📂 Categorized symbol browsing
- 📱 Support for iOS and macOS
- 🚀 Easy integration with SwiftUI
- 🎯 Built with SwiftUI and native system components

## Requirements

- iOS 17.0+
- macOS 14.0+
- Swift 6.1+

## Installation

### Swift Package Manager

Add the package to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/wangqiyangx/SFSymbolPicker.git", from: "1.0.0")
]
```

## Usage

### Basic Usage

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

### Customization

The picker can be customized through various parameters:

```swift
SFSymbolPicker(
    "Custom Title",  // The title displayed above the picker
    selection: $selectedSymbol  // Binding to the selected symbol
)
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Acknowledgments

- Apple for creating SF Symbols
- The SwiftUI team for making this possible
