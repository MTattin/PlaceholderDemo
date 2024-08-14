//
//  DefaultPlaceholderView
//
//  © 2023 Masakiyo Tachikawa
//

import SwiftUI

// MARK: - DefaultPlaceholderView

struct DefaultPlaceholderView: View {

    // MARK: - Properties

    @State private var isLoading = true

    // MARK: - Views

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }

            sampleView

            sampleListView

            Button {
                if isLoading { return }
                showPlaceholder()
            } label: {
                Text("もう一回表示")
            }
        }
        .padding()
        .redacted(reason: isLoading ? .placeholder : [])
        .task {
            showPlaceholder()
        }
    }

    private var sampleView: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.tint)
                    .frame(width: 100, height: 100)
                Image(systemName: "figure.2.and.child.holdinghands")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }

            Text("Welcome to MyApp")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)

            Text("Description text")
                .font(.title2)
        }
        .padding()
    }

    private var sampleListView: some View {
        List {
            ForEach(1...3, id: \.self) { index in
                HStack {
                    Image(systemName: "\(index).square.fill")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("List item \(index)")
                }
            }
        }
        .listStyle(PlainListStyle())
        .frame(height: 160)
    }
}

private extension DefaultPlaceholderView {

    // MARK: - Conveniences

    func showPlaceholder() {
        Task {
            defer { isLoading = false }
            isLoading = true
            try await Task.sleep(for: .seconds(5))
        }
    }
}

#Preview {
    DefaultPlaceholderView()
}
