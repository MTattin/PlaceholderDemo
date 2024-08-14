//
//  ContentView
//  
//  © 2023 Masakiyo Tachikawa
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    // MARK: - Properties

    @State private var path = [ScreenType]()

    private let pathProvider = PathProvider()

    // MARK: - Views

    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(ScreenType.allCases) {
                    listItemView(using: $0)
                }
            }
            .listStyle(PlainListStyle())
            .padding(.vertical)
            .navigationDestination(for: ScreenType.self) {
                pathProvider.makeView(using: $0)
            }
        }
        .environment(\.path, path)
        .environment(\.pathProvider, pathProvider)
    }

    private func listItemView(using type: ScreenType) -> some View {
        Button {
            path.append(type)
        } label: {
            Label(
                title: { Text(type.text).font(.body) },
                icon: { path.first == type ? Image(systemName: "checkmark") : type.icon }
            )
        }
        .contentTransition(.symbolEffect(.replace))
    }
}

#Preview {
    ContentView()
}
