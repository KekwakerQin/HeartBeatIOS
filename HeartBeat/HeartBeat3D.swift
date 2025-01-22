import SwiftUI
import SceneKit

struct HeartBeat3D : View {
    @State private var scene = SCNScene() // Определяем сцену как свойство
    @State private var currentAngleX: Float = 0.0
    @State private var currentAngleY: Float = 0.0
    
    @State private var lastDragTime: Date? = nil // Время последнего жеста
    @State private var lastDragPosition: CGSize = .zero // Позиция последнего жеста
    @State private var rotationSpeed: CGFloat = 0.0 // Скорость вращения
    @State private var currentRotation = simd_quatf(angle: 0, axis: simd_float3(0, 1, 0)) // Текущий поворот объекта

    
    var body: some View {
        SceneView(
            scene: scene, // Используем созданную сцену
            options: [.autoenablesDefaultLighting, .allowsCameraControl]
        )
        .ignoresSafeArea() // Растягиваем сцену на весь экран
        .gesture(
            DragGesture()
                .onChanged { value in
                    handleDrag(value: value) // Обрабатываем вращение
                    evaluateSpeed()
                }
                .onEnded { _ in
                    evaluateSpeed()
                }
        )
        .onAppear {
            setupScene() // Настраиваем сцену при появлении
        }
        
        
    }
    
    private func setupScene() {
            // Создаём звезду
            let starNode = createStarNode()
            scene.rootNode.addChildNode(starNode) // Добавляем звезду в сцену

            // Настраиваем камеру
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            cameraNode.position = SCNVector3(0, 0, 5) // Камера перед звездой
            scene.rootNode.addChildNode(cameraNode)
        }

        // Создаём узел звезды
        private func createStarNode() -> SCNNode {
            let starNode = SCNNode()

            // Пример создания звезды программно
            let path = UIBezierPath()
            let points: [(CGFloat, CGFloat)] = [
                (0, 0.3), (0.2, 0.5), (0.5, 0.5),
                (0.7, 0.3), (0.7, 0), (0, -0.6),
                (-0.7, 0), (-0.7, 0.3), (-0.5, 0.5),
                (-0.2, 0.5)
            ]
            let scale: CGFloat = 1.0
            path.move(to: CGPoint(x: points[0].0 * scale, y: points[0].1 * scale))
            for point in points {
                path.addLine(to: CGPoint(x: point.0 * scale, y: point.1 * scale))
            }
            path.close()

            let geometry = SCNShape(path: path, extrusionDepth: 0.3)
            geometry.firstMaterial?.diffuse.contents = UIColor.systemRed // Цвет звезды
            starNode.geometry = geometry

            return starNode
        }

        // Обрабатываем жест вращения
        private func handleDrag(value: DragGesture.Value) {
            let translation = value.translation
            let angleX = Float(translation.width) * .pi / 180 // Ротация по X
            let angleY = Float(translation.height) * .pi / 180 // Ротация по Y

            currentAngleX += angleX
            currentAngleY += angleY

            let rotationX = simd_quatf(angle: angleX, axis: simd_float3(1, 0, 0))
            let rotationY = simd_quatf(angle: angleY, axis: simd_float3(0, 1, 0))
            
            currentRotation = simd_mul(rotationY, simd_mul(rotationX, currentRotation))

            
            // Рассчитываем скорость жеста
                   if let lastTime = lastDragTime {
                       let timeInterval = Date().timeIntervalSince(lastTime)
                       let deltaX = translation.width - lastDragPosition.width
                       let deltaY = translation.height - lastDragPosition.height
                       rotationSpeed = CGFloat(sqrt(deltaX * deltaX + deltaY * deltaY)) / CGFloat(timeInterval)
                   }
            lastDragTime = Date()
                    lastDragPosition = translation
            
            DispatchQueue.main.async {
                let starNode = scene.rootNode.childNodes.first // Получаем звезду
                starNode?.eulerAngles = SCNVector3(currentAngleY, currentAngleX, 0) // Применяем вращение
                starNode?.simdOrientation = currentRotation // Применяем кватернионное вращение
            }
        }
    private func evaluateSpeed() {
            if rotationSpeed > 50.0 { // Условие для высокой скорости
                print("Высокая скорость вращения: \(rotationSpeed)")
            } else {
                print("Низкая скорость вращения: \(rotationSpeed)")
            }

            // Сбрасываем скорость
            rotationSpeed = 0.0
            lastDragTime = nil
            lastDragPosition = .zero
        }
}

#Preview {
    HeartBeat3D()
}
