// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// A SwiftUI component for picking SF Symbols with a beautiful and intuitive interface.
///
/// SFSymbolPicker provides a simple way to integrate SF Symbol selection into your SwiftUI apps.
/// It supports both iOS and macOS platforms, and offers a categorized view of all available SF Symbols.
///
/// ## Features
/// - Beautiful grid-based symbol picker interface
/// - Categorized symbol browsing
/// - Support for iOS and macOS
/// - Easy integration with SwiftUI
///
/// ## Requirements
/// - iOS 17.0+
/// - macOS 14.0+
/// - watchOS 10.0+
/// - Swift 6.1+
///
/// ## Installation
/// Add the package to your project using Swift Package Manager:
/// ```swift
/// dependencies: [
///     .package(url: "https://github.com/wangqiyangX/SFSymbolPicker.git", from: "1.0.0")
/// ]
/// ```
let package = Package(
    name: "SFSymbolPicker",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
    ],
    products: [
        /// The main library that provides the SF Symbol picker functionality.
        .library(
            name: "SFSymbolPicker",
            targets: ["SFSymbolPicker"])
    ],
    targets: [
        /// The main target containing the SF Symbol picker implementation.
        .target(
            name: "SFSymbolPicker"),
        /// Tests for the SF Symbol picker functionality.
        .testTarget(
            name: "SFSymbolPickerTests",
            dependencies: ["SFSymbolPicker"]
        ),
    ]
)
