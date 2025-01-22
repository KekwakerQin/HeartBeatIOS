import SceneKit

func makeScene() -> SCNScene {
        let scene = SCNScene()

        // Импортируем звезду из файла
        if let starNode = loadStarModel() {
            scene.rootNode.addChildNode(starNode) // Добавляем звезду в сцену
        }

        // Настраиваем камеру
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 5) // Камера перед звездой
        scene.rootNode.addChildNode(cameraNode)

        return scene
    }

