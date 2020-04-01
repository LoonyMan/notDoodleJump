import SpriteKit

class GreenBackground: SKSpriteNode {
    
    static let sizeX: CGFloat = 241 * 1
    static let sizeY: CGFloat = 241 * 1
    
    static func populate(at point: CGPoint) -> GreenBackground {
        
        let texture = Textures.shared.greenBackground
        
        let greenBackground = GreenBackground(texture: texture)
        
        greenBackground.name = "background"
        greenBackground.zPosition = 4
        greenBackground.position = point
        greenBackground.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return greenBackground
    }
    
    
}
