//
//  SFSymbolPickerSheetView.swift
//  SFSymbolPicker
//
//  Created by wangqiyangX on 2025/4/22.
//
//

import SwiftUI

/// A view that displays a sheet for picking SF Symbols
/// This view provides a grid-based interface for selecting SF Symbols with search and category filtering capabilities
struct SFSymbolPickerSheetView: View {
    /// The title of the picker that appears in the navigation bar
    let titleKey: LocalizedStringKey

    /// The currently selected symbol category for filtering symbols
    @State private var selectedSymbolCategory: ESFSymbolCategory = .all

    /// The search text used to filter symbols
    @State private var searchSymbol: String = ""

    /// The binding to the selected symbol that will be updated when a symbol is chosen
    @Binding var selectedSymbol: String

    /// Environment value for dismissing the sheet
    @Environment(\.dismiss) private var dismiss

    /// Computed property that returns filtered symbols based on search text and selected category
    /// - Returns: Array of symbol names that match the current search criteria
    var filteredSymbols: [String] {
        if searchSymbol.isEmpty {
            return selectedSymbolCategory.symbols
        } else {
            return selectedSymbolCategory.symbols.filter { symbol in
                symbol.localizedStandardContains(searchSymbol)
            }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 80))],
                    spacing: 20
                ) {
                    ForEach(filteredSymbols, id: \.self) { symbol in
                        Image(systemName: symbol)
                            .frame(
                                maxWidth: .infinity,
                                minHeight: 80
                            )
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.ultraThickMaterial)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        selectedSymbol == symbol
                                            ? Color.accentColor : Color.clear,
                                        lineWidth: 2
                                    )
                            }
                            .onTapGesture {
                                selectedSymbol = symbol
                            }
                    }
                }
                .padding()
            }
            .navigationTitle(titleKey)
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Picker("Category", selection: $selectedSymbolCategory) {
                        ForEach(ESFSymbolCategory.allCases) { category in
                            Text(category.name)
                        }
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.subheadline)
                            .bold()
                            .padding(4)
                            .foregroundStyle(.secondary)
                            .padding(2)
                            .background {
                                Circle()
                                    .fill(.ultraThickMaterial)
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
            .searchable(text: $searchSymbol)
        }
    }
}

/// A view that provides a button to show the SF Symbol picker sheet
/// This is the main public interface for the SF Symbol picker
public struct SFSymbolPicker: View {
    /// The title of the picker that appears in the navigation bar
    let titleKey: LocalizedStringKey

    /// The binding to the selected symbol that will be updated when a symbol is chosen
    @Binding var selection: String

    /// State for controlling the sheet presentation
    @State private var showSheet: Bool = false

    /// Creates a new SF Symbol picker
    /// - Parameters:
    ///   - titleKey: The title to display in the navigation bar
    ///   - selection: A binding to the selected symbol
    public init(_ titleKey: LocalizedStringKey, selection: Binding<String>) {
        self.titleKey = titleKey
        self._selection = selection
    }

    public var body: some View {
        LabeledContent {
            Button {
                withAnimation {
                    showSheet.toggle()
                }
            } label: {
                Image(systemName: selection)
            }
            .buttonStyle(.plain)
        } label: {
            Text(titleKey)
        }
        .sheet(isPresented: $showSheet) {
            SFSymbolPickerSheetView(
                titleKey: titleKey,
                selectedSymbol: $selection
            )
            .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    @Previewable
    @State var selectedSymbol: String = "book"

    Form {
        SFSymbolPicker("Event icon", selection: $selectedSymbol)
    }
}
