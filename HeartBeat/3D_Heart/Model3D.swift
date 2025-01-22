import SceneKit

func createStarNode() -> SCNNode {
    let starNode = SCNNode()

    // Создаём 5-лучевую звезду программно
    let path = UIBezierPath()
    let points: [(CGFloat, CGFloat)] = [
        (0, 1), (0.2245, 0.309),
        (0.951, 0.309), (0.363, -0.118),
        (0.588, -0.809), (0, -0.382),
        (-0.588, -0.809), (-0.363, -0.118),
        (-0.951, 0.309), (-0.2245, 0.309)
    ]
    let scale: CGFloat = 5.0

    path.move(to: CGPoint(x: points[0].0 * scale, y: points[0].1 * scale))
    for point in points {
        path.addLine(to: CGPoint(x: point.0 * scale, y: point.1 * scale))
    }
    path.close()

    let shape = SCNShape(path: path, extrusionDepth: 0.5)
    shape.firstMaterial?.diffuse.contents = UIColor.systemYellow
    starNode.geometry = shape

    return starNode
}
