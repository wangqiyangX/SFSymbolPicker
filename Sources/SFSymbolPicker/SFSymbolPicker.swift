import SwiftUI

struct SFSymbolPickerSheetView: View {
    let titleKey: LocalizedStringKey
    @State private var selectedSymbolCategory: ESFSymbolCategory = .all
    @Binding var selectedSymbol: String

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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Picker("Category", selection: $selectedSymbolCategory) {
                        ForEach(ESFSymbolCategory.allCases) { category in
                            Text(category.name)
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
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

struct SFSymbolPicker: View {
    let titleKey: LocalizedStringKey
    @Binding var selection: String

    @State private var showSheet: Bool = false

    init(_ titleKey: LocalizedStringKey, selection: Binding<String>) {
        self.titleKey = titleKey
        self._selection = selection
    }

    var body: some View {
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
            SFSymbolPickerSheetView(titleKey: titleKey, selectedSymbol: $selection)
        }
    }
}

#Preview {
    Form {
        SFSymbolPicker("Event icon", selection: .constant("book"))
    }
}
