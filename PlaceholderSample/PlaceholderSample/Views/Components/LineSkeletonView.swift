//
//  LineSkeletonView
//  
//  © 2023 Masakiyo Tachikawa
//

import SwiftUI

// MARK: - LineSkeletonView

struct LineSkeletonView: View {

    // MARK: - Properties

    @State private var gradientStart = UnitPoint(x: -1, y: 0.5)
    @State private var gradientEnd = UnitPoint(x: 0, y: 0.5)

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
        ZStack {
            baseColor
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: gradientStart,
                endPoint: gradientEnd
            )
            .scaleEffect(x: 2)
        }
        .clipped()
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                gradientStart = UnitPoint(x: 1, y: 0.5)
                gradientEnd = UnitPoint(x: 2, y: 0.5)
            }
        }
    }
}

#Preview {
    Group {
        LineSkeletonView(baseColor: .yellow)
            .frame(width: 300, height: 150)

        LineSkeletonView(baseColor: .black)
            .frame(width: 150, height: 300)
    }
}
