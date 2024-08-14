//
//  VerticalLineSkeletonView
//
//  © 2023 Masakiyo Tachikawa
//

import SwiftUI

// MARK: - VerticalLineSkeletonView

struct VerticalLineSkeletonView: View {

    // MARK: - Properties

    @State private var gradientStart = UnitPoint(x: 0.5, y: -1)
    @State private var gradientEnd = UnitPoint(x: 0.5, y: 0)

    let baseColor: Color

    private var colors: [Color] {
        [
            .clear,
            .clear,
            Color.white.opacity(0.2),
            .clear,
            .clear,
        ]
    }

    // MARK: - Views

    var body: some View {
        Rectangle()
            .fill(.clear)
            .background {
                ZStack {
                    baseColor
                    LinearGradient(
                        gradient: Gradient(colors: colors),
                        startPoint: gradientStart,
                        endPoint: gradientEnd
                    )
                    .scaleEffect(x: 2)
                }
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    gradientStart = UnitPoint(x: 0.5, y: 1)
                    gradientEnd = UnitPoint(x: 0.5, y: 2)
                }
            }
    }
}

#Preview {
    Group {
        VerticalLineSkeletonView(baseColor: .yellow)
            .frame(width: 300, height: 150)

        VerticalLineSkeletonView(baseColor: .black)
            .frame(width: 150, height: 300)
    }
}
