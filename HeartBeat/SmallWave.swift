import SwiftUI

struct RainView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<100, id: \.self) { index in
                    RainDrop()
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: -200...geometry.size.height)
                        )
                }
            }
        }
    }
}

#Preview {
    RainView()
}
