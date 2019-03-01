import UIKit

final class SnowFlakeEmitter {
    private let birthRate: Float = 80
    
    private let snowLayer = CAEmitterLayer()

    func injectSnowLayer(into view: UIView) {
        let width = max(view.bounds.width, view.bounds.height)
        
        snowLayer.emitterPosition = CGPoint(x: width / 2.0, y: -50)
        snowLayer.emitterSize = CGSize(width: width, height: 0)
        snowLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowLayer.beginTime = CACurrentMediaTime()
        snowLayer.emitterCells = [.snowFlake].map(makeSnowCell)

        view.layer.addSublayer(snowLayer)
    }

    func start() {
        snowLayer.birthRate = birthRate
    }
    
    func stop() {
        snowLayer.birthRate = 0
    }
    
    func removeFromSuperlayer() {
        snowLayer.removeFromSuperlayer()
    }
}

private extension SnowFlakeEmitter {
    func makeSnowCell(_ image: UIImage) -> CAEmitterCell {
        let snowCell = CAEmitterCell()
        snowCell.contents = image.cgImage
        snowCell.scale = 0.06
        snowCell.scaleRange = 0.2
        snowCell.emissionRange = .pi
        snowCell.lifetime = 20.0
        snowCell.birthRate = birthRate
        snowCell.velocity = -30
        snowCell.velocityRange = -20
        snowCell.yAcceleration = 30
        snowCell.xAcceleration = 5
        snowCell.spin = -0.5
        snowCell.spinRange = 1.0
        return snowCell
    }
}

extension UIImage {
    static let snowFlake = UIImage(named: "snowFlake")!
}
