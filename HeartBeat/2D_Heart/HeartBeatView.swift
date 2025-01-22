import SwiftUI

struct HeartBeatView : View {
    @State private var scale: CGFloat = 1.0
    @State private var colorHeart = Color(.white)
    @State private var radiusShadowHeart = 5
//    @State private var gradientRadius: CGFloat = 50 // Радиус градиента для фона

        // Параметры анимации
        var animationDuration: Double = 0.6 // Скорость одного цикла анимации (секунды)
        var lineWidth: CGFloat = 6 // Толщина обводки сердца
    var heartSizeX = 200.0 // Размер сердца
    var heartSizeY = 200.0
        var gradientColors: [Color] = [.red, .pink] // Цвета градиента для обводки
//    var gradientColorsBg: [Color] = [.red.opacity(0.3), .black] // Цвета градиента для фона

        
        var body: some View {
            ZStack {
                // Чёрный фон на весь экран
//                RadialGradient(
////                                gradient: Gradient(colors: gradientColorsBg),
//                                center: .center,
//                                startRadius: 0,
//                                endRadius: gradientRadius
//                            )
//                .ignoresSafeArea()
                // Сердце с анимацией
                HeartShape()
                    .foregroundColor(colorHeart)
                    .frame(width: heartSizeX, height: heartSizeY) // Размер сердца
                    .offset(y: heartSizeY * 0.1 * -1)
                    .scaleEffect(scale) // Анимация увеличения/уменьшения
//                    .animation(
//                        Animation.timingCurve(0.0, 0.9, 0.7, 0.5, duration: 0.7)
//                            .repeatForever(autoreverses: true), // Повторяющаяся анимация
//                        value: scale
//                    )
                    .onAppear {
                        startHeartbeat()
//                        scale = 1.2 // Начальный масштаб сердца
                    }
                    .shadow(color: colorHeart, radius: CGFloat(radiusShadowHeart))
            }
        }
    
    private func startHeartbeat() {
           let beatDuration = 0.4 // Длительность одного сокращения
           let relaxDuration = 0.4 // Длительность расслабления
           let pauseDuration = 0.4 // Пауза между ударами
           
           // Циклическая анимация
           withAnimation(.easeIn(duration: beatDuration)) {
               scale = 1.3 // Резкое увеличение
               colorHeart = .red
               radiusShadowHeart = 15
//               gradientRadius = 300
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + beatDuration) {
               withAnimation(.easeOut(duration: relaxDuration)) {
                   scale = 1.0 // Плавное уменьшение
                   colorHeart = .white
                   radiusShadowHeart = 5
//                   gradientRadius = 50
               }
               let vibration = UIImpactFeedbackGenerator(style: .heavy)
               vibration.impactOccurred()

               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                   vibration.impactOccurred()

               }
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + beatDuration + relaxDuration + pauseDuration) {
               

               startHeartbeat() // Рестарт цикла
           }
       }
}
#Preview {
    HeartBeatView()
}
