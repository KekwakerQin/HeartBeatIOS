import SwiftUI

struct ContinuousWaveEffectView: View {
    @State private var isAnimating = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Волновые круги
                ForEach(0..<5) { i in
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue.opacity(0.5), .cyan.opacity(0.3)]),
                                startPoint: .center,
                                endPoint: .top
                            ),
                            lineWidth: 2
                        )
                        .frame(
                            width: isAnimating ? geometry.size.width * 1.5 : 0,
                            height: isAnimating ? geometry.size.width * 1.5 : 0
                        )
                        .scaleEffect(isAnimating ? 1 : 0)
                        .blur(radius: 5)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .animation(
                            Animation.easeInOut(duration: 2)
                                .delay(Double(i) * 0.4)
                                .repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                }
            }
            .onAppear {
                isAnimating = true
            }
        }
        .ignoresSafeArea()
    }
}
