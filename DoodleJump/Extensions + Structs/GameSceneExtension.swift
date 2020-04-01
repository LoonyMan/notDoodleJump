import SpriteKit
import AudioToolbox

extension GameScene {
    
    func spawnFloor(at point: CGPoint) {
        
        let floor: Floor
        let random = arc4random_uniform(20)
        
        if random >= 3 && random < 8 {
            floor = BlueFloor(at: point)
        } else if random >= 0 && random < 3 {
            floor = RedFloor(at: point)
        } else {
            floor = WhiteFloor(at: point)
        }
        
        self.addChild(floor)
    }
    
    func generateBackground() {
        var x: CGFloat = 0
        
        while (x < self.size.width) {
            let background = Background.populate(at: CGPoint(x: x, y: levelBckgrnd))
            x += Background.sizeX
            
            
            
            self.addChild(background)
        }
    }
    
    func setupPlayer(at point: CGPoint) {
        
        player = Player.populate(at: point)
        
        self.addChild(player)
        
        setupMotionManager()
    }
    
    private func setupMotionManager() {
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let data = data {
                    let acceleration = data.acceleration
                    self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
    }
    
    
    func setupCamera() {
        camera = myCamera
        camera!.position.x = screenSize.width / 2
        camera!.position.y = maxPlayerHeightForCam
    }
    
}



extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
        let playerBitMask = BitMaskCategory.player
        let floorBitMask = BitMaskCategory.floor
        let redFloorBitMask = BitMaskCategory.redFloor
        
        if bodyA == playerBitMask && bodyB == floorBitMask || bodyB == playerBitMask && bodyA == floorBitMask {
            onFloor = true
            
            player.physicsBody?.velocity = CGVector.zero
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
            vibrate()
            
            player.setupJumpTexture()
            
        } else if bodyA == playerBitMask && bodyB == redFloorBitMask || bodyB == playerBitMask && bodyA == redFloorBitMask {
         
            onFloor = true
            
            player.physicsBody?.velocity = CGVector.zero
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1))
            vibrate()
            
            player.setupJumpTexture()
            
        } else {
            print("ooops... idk who is who +")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
        let bodyA = contact.bodyA.categoryBitMask
        let bodyB = contact.bodyB.categoryBitMask
        let playerBitMask = BitMaskCategory.player
        let floorBitMask = BitMaskCategory.floor
        let redFloorBitMask = BitMaskCategory.redFloor
        
        if bodyA == playerBitMask && bodyB == floorBitMask || bodyB == playerBitMask && bodyA == floorBitMask {
            onFloor = false
            player.set(toucheble: false)
            
            
            player.physicsBody?.velocity = CGVector.zero
            
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1000))
            
            
        } else if bodyA == playerBitMask && bodyB == redFloorBitMask || bodyB == playerBitMask && bodyA == redFloorBitMask {
            onFloor = false
            player.set(toucheble: false)
            
            let redFloor: SKPhysicsBody!
            
            if bodyA == redFloorBitMask {
                redFloor = contact.bodyA
                
            } else if bodyB == redFloorBitMask {
                redFloor = contact.bodyB
            } else {redFloor = nil}
            
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 600))
            redFloor.affectedByGravity = true
            redFloor.isDynamic = true
            redFloor.categoryBitMask = BitMaskCategory.none
            redFloor.collisionBitMask = BitMaskCategory.none
            redFloor.contactTestBitMask = BitMaskCategory.none
            
        } else {
            print("ooops... idk who is who +")
        }
    }
    
    private func vibrate() {
        if #available(iOS 10.0, *) {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
        } else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
    
    func saveBestScore(score: Int) {
        if MenuScene.takeBestScore() < score{
            MenuScene.ud.set(score, forKey: MenuScene.bestScore)
        }
    }
}
