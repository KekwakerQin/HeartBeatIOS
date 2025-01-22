import SwiftUI

struct RainDrop: View {
    @State private var positionY: CGFloat = -200
    let animationDuration: Double = 1.5

    var body: some View {
        Rectangle()
            .fill(Color.blue.opacity(0.5))
            .frame(width: 2, height: 10)
            .offset(y: positionY)
            .onAppear {
                positionY = UIScreen.main.bounds.height + 50
                withAnimation(
                    Animation.linear(duration: animationDuration)
                        .repeatForever(autoreverses: false)
                ) {
                    positionY = -50
                }
            }
    }
}
