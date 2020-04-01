import SpriteKit

class Player: SKSpriteNode {
    
    var jumping = false
    
    static let leftJump = Textures.shared.leftJump
    static let leftStay = Textures.shared.leftStay
    static let rightJump = Textures.shared.rightJump
    static let rightStay = Textures.shared.rightStay
    
    static let sizeX = 110 * 1
    static let sizeY = 80 * 1
    
    static func populate(at point: CGPoint) -> Player {
    
        let texture = Bool.random() ? Player.leftStay : Player.rightStay
        let player = Player(texture: texture)
        
        player.position = point
        player.zPosition = 20
        player.setScale(0.8)
        player.name = "player"
        player.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width * 0.4, height: 1))//15))
        
        //player.physicsBody?.friction = 1
        player.physicsBody?.mass = 1
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = BitMaskCategory.player
        player.physicsBody?.collisionBitMask = BitMaskCategory.floor
        player.physicsBody?.contactTestBitMask = BitMaskCategory.floor
        //player.physicsBody?.restitution = 0
        
        return player
        
        
    }
    
    func changeTexture(way: Way) {
        if way == .left {
            self.texture = self.jumping ? Player.leftJump : Player.leftStay
        } else { self.texture = self.jumping ? Player.rightJump : Player.rightStay }
    }
    
    func set(toucheble: Bool) {
        jumping = toucheble
        
        let categoryBitMask = toucheble ? BitMaskCategory.player : BitMaskCategory.none
        let collisionBitMask = toucheble ? BitMaskCategory.floor : BitMaskCategory.none
        let contactTestBitMask = toucheble ? BitMaskCategory.floor : BitMaskCategory.none
        
        self.physicsBody?.categoryBitMask = categoryBitMask
        self.physicsBody?.collisionBitMask = collisionBitMask
        self.physicsBody?.contactTestBitMask = contactTestBitMask
    }
    
    func setupJumpTexture() {
        self.texture = self.texture == Player.leftStay ? Player.leftJump : Player.rightJump
    }
    
}
