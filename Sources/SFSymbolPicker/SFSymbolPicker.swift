//
//  SFSymbolPickerSheetView.swift
//  SFSymbolPicker
//
//  Created by wangqiyangX on 2025/4/22.
//
//

import SwiftUI

/// A view that displays a sheet for picking SF Symbols
struct SFSymbolPickerSheetView: View {
    /// The title of the picker
    let titleKey: LocalizedStringKey

    /// The currently selected symbol category
    @State private var selectedSymbolCategory: ESFSymbolCategory = .all

    /// The binding to the selected symbol
    @Binding var selectedSymbol: String

    /// Environment value for dismissing the sheet
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 80))],
                    spacing: 20
                ) {
                    ForEach(selectedSymbolCategory.symbols, id: \.self) {
                        symbol in
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
                ToolbarItem(placement: .primaryAction) {
                    Picker("Category", selection: $selectedSymbolCategory) {
                        ForEach(ESFSymbolCategory.allCases) { category in
                            Text(category.name)
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        withAnimation {
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

/// A view that provides a button to show the SF Symbol picker sheet
public struct SFSymbolPicker: View {
    /// The title of the picker
    let titleKey: LocalizedStringKey

    /// The binding to the selected symbol
    @Binding var selection: String

    /// State for controlling the sheet presentation
    @State private var showSheet: Bool = false

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
        }
    }
}

#Preview {
    Form {
        SFSymbolPicker("Event icon", selection: .constant("book"))
    }
}
