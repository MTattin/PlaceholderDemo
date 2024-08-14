//
//  Helper
//  
//  © 2023 Masakiyo Tachikawa
//

import SwiftUI

// MARK: - PathProviderEnvironment

struct PathProviderEnvironmentKey: EnvironmentKey {
    static var defaultValue: PathProvider = .init()
}

extension EnvironmentValues {
    var pathProvider: PathProvider {
        get { self[PathProviderEnvironmentKey.self] }
        set { self[PathProviderEnvironmentKey.self] = newValue }
    }
}

struct PathProvider {
    @ViewBuilder
    func makeView(using type: ScreenType) -> some View {
        switch type {
        case .defaultPlaceholder:
            DefaultPlaceholderView()
        case .editDefaultPlaceholder:
            EditDefaultPlaceholderView()
        case .customPlaceholder:
            Text("工事中")
        case .customVerticalPlaceholder:
            Text("工事中")
        }
    }
}

// MARK: - Path

struct PathEnvironmentKey: EnvironmentKey {
    static var defaultValue: [ScreenType] = []
}

extension EnvironmentValues {
    var path: [ScreenType] {
        get { self[PathEnvironmentKey.self] }
        set { self[PathEnvironmentKey.self] = newValue }
    }
}

// MARK: - ScreenType

enum ScreenType: CaseIterable {
    case defaultPlaceholder
    case editDefaultPlaceholder
    case customPlaceholder
    case customVerticalPlaceholder

    // MARK: - Properties

    var text: String {
        switch self {
        case .defaultPlaceholder:
            "標準Placeholder"
        case .editDefaultPlaceholder:
            "標準Placeholder（非表示追加）"
        case .customPlaceholder:
            "オリジナルPlaceholder（横方向）"
        case .customVerticalPlaceholder:
            "オリジナルPlaceholder（縦方向）"
        }
    }

    var icon: Image {
        switch self {
        case .defaultPlaceholder, .editDefaultPlaceholder:
            Image(systemName: "placeholdertext.fill")
        case .customPlaceholder, .customVerticalPlaceholder:
            Image(systemName: "c.square.fill")
        }
    }
}

extension ScreenType: Identifiable {
    var id: Self { self }
}

// MARK: - Redacted Modifier

struct RedactingView<Input: View, Output: View>: View {

    // MARK: - Properties

    @Environment(\.redactionReasons) private var reasons

    let content: Input
    let modifier: (Input) -> Output

    // MARK: - Views

    var body: some View {
        if reasons.isEmpty {
            content
        } else {
            modifier(content)
        }
    }
}

extension View {
    func whenRedacted<T: View>(
        apply modifier: @escaping (Self) -> T
    ) -> some View {
        RedactingView(content: self, modifier: modifier)
    }
}
