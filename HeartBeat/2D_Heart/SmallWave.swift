import SwiftUI

struct SmallWave: View {
    let position: CGPoint
        @State private var scale: CGFloat = 0.5
        @State private var opacity: Double = 1.0

        var body: some View {
            Circle()
                .stroke(Color.white.opacity(opacity), lineWidth: 0.5)
                .frame(width: 20, height: 20)
                .scaleEffect(scale)
                .position(position)
                .onAppear {
                    withAnimation(Animation.easeOut(duration: 1.0)) {
                        scale = 2.0
                        opacity = 0.0
                    }
                }
        }
}
