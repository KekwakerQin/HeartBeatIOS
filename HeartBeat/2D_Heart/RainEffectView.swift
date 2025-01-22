import SwiftUI
struct RainEffectView : View {@State private var wavePositions: [Wave] = []
    
    var body: some View {
        ZStack {
            // Фон
            Color.black.ignoresSafeArea()

            // Волны дождя
            ForEach(wavePositions) { wave in
                SmallWave(position: wave.position)
            }
        }
        .onAppear(perform: startRainEffect)
    }

    private func startRainEffect() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            addRandomWave()
        }
    }

    private func addRandomWave() {
        let randomPosition = CGPoint(
            x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
            y: CGFloat.random(in: 0...UIScreen.main.bounds.height)
        )
        let newWave = Wave(id: UUID(), position: randomPosition)

        wavePositions.append(newWave)

        // Удаляем только конкретную волну через время
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            wavePositions.removeAll { $0.id == newWave.id }
        }
    }
}

struct Wave: Identifiable {
    let id: UUID
    let position: CGPoint
}

#Preview() {
    RainEffectView()
}
