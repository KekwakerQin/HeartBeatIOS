import SwiftUI

struct HeartShape: Shape {

    func path(in rect: CGRect) -> Path {
            var path = Path()
            // Размеры прямоугольника
            let width = 200.0
            let height = 200.0
            // Пропорции для эстетики
            let topCurveHeight = height * 0.35
            let controlPointOffsetX = width * 0.2
            let controlPointOffsetY = height * 0.3

            // Начинаем с нижней центральной точки
            path.move(to: CGPoint(x: width / 2, y: height))

            // Левая нижняя дуга
            path.addCurve(
                to: CGPoint(x: 0, y: height / 3), // Конечная точка дуги
                control1: CGPoint(x: width / 2 - controlPointOffsetX, y: height - controlPointOffsetY), // Первый контрольный
                control2: CGPoint(x: 0, y: height * 0.6) // Второй контрольный
            )

            // Левая верхняя дуга
            path.addArc(
                center: CGPoint(x: width * 0.25, y: topCurveHeight), // Центр дуги
                radius: width * 0.25, // Радиус
                startAngle: .degrees(180), // Начальный угол
                endAngle: .degrees(0), // Конечный угол
                clockwise: false // Против часовой стрелки
            )

            // Правая верхняя дуга
            path.addArc(
                center: CGPoint(x: width * 0.75, y: topCurveHeight), // Центр дуги
                radius: width * 0.25, // Радиус
                startAngle: .degrees(180), // Начальный угол
                endAngle: .degrees(0), // Конечный угол
                clockwise: false // Против часовой стрелки
            )

            // Правая нижняя дуга
            path.addCurve(
                to: CGPoint(x: width / 2, y: height), // Конечная точка дуги
                control1: CGPoint(x: width, y: height * 0.6), // Первый контрольный
                control2: CGPoint(x: width / 2 + controlPointOffsetX, y: height - controlPointOffsetY) // Второй контрольный
            )

            return path
        }
}

#Preview {
    HeartShape()
}
