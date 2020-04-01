import SpriteKit

class Floor: SKSpriteNode {
    
    private let initialSize = CGSize(width: 103, height: 30)
    
    init(texture: SKTexture) {
        
        super.init(texture: texture, color: .clear, size: initialSize)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.8)
        self.zPosition = 5
        //self.position = point
        self.setScale(0.7)
        self.name = "floor"
            
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width
            , height: self.size.height / 2))
        //8))
            
            //self.physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = BitMaskCategory.floor
        self.physicsBody?.collisionBitMask = BitMaskCategory.player
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player
        
        self.physicsBody?.mass = 100
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
