//
//  CustomVerticalPlaceholderView
//
//  © 2023 Masakiyo Tachikawa
//

import SwiftUI

// MARK: - CustomVerticalPlaceholderView

struct CustomVerticalPlaceholderView: View {

    // MARK: - Properties

    @State private var isLoading = true

    // MARK: - Views

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .whenRedacted { $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .gray.opacity(0.3)) } }
                Text("Hello, world!")
                    .whenRedacted { $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .blue.opacity(0.3)) } }
            }

            sampleView

            sampleListView

            Button {
                if isLoading { return }
                showPlaceholder()
            } label: {
                Text("もう一回表示")
            }
            .whenRedacted { _ in
                VerticalLineSkeletonView(baseColor: .blue.opacity(0.3))
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .cornerRadius(10)
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
                    .whenRedacted { $0.hidden() }
            }
            .whenRedacted { $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .yellow.opacity(0.3)) } }


            Text("Welcome to MyApp")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
                .whenRedacted { $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .red.opacity(0.3)) } }

            Text("Description text")
                .font(.title2)
                .whenRedacted { $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .red.opacity(0.3)) } }
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
                        .whenRedacted {
                            $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .blue.opacity(0.3)) }
                        }
                    Text("List item \(index)")
                        .whenRedacted {
                            $0.hidden().overlay { VerticalLineSkeletonView(baseColor: .black.opacity(0.3)) }
                        }
                }
                .whenRedacted {
                    if index == 2 {
                        AnyView($0.hidden())
                    } else {
                        AnyView($0)
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .frame(height: 160)
    }
}

private extension CustomVerticalPlaceholderView {

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
    CustomVerticalPlaceholderView()
}
