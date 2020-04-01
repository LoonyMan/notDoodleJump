
import SpriteKit

class MenuScene: SKScene {
    static let ud = UserDefaults.standard
    static let bestScore = "bestScore"
    static let screenSize = UIScreen.main.bounds.size
    
    var touchesMovedArray: [CGPoint] = []
    
    var startPoint: CGPoint!
    var finishPoint: CGPoint!
    
    var touched = false
    var lastPositionX: CGFloat = 0
    var screenShot: UIImage?
    var score: String?
    var player: Player?
    var levelBckgrnd: CGFloat = 0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2.5)
        
        if let screenShot = self.screenShot, let score = self.score {
            self.addChild(MenuSceneHUD.populateBackground(screenshot: screenShot))
            self.addChild(MenuSceneHUD.populateScoreLabel(score: score))
            self.addChild(MenuSceneHUD.populateBestScoreLabel(bestscore: String(MenuScene.takeBestScore())))
            self.addChild(MenuSceneHUD.populatePlayGameButton())
            
        } else {
            createBackground()
            self.addChild(MenuSceneHUD.populateBestScoreLabel(bestscore: String(MenuScene.takeBestScore())))
            self.addChild(MenuSceneHUD.populatePlayGameButton())
        }
        let randomPoint = CGPoint(x: CGFloat.random(in: 40...self.size.width - 40), y: self.size.height + 100)
        player = MenuSceneHUD.populatePlayer(at: randomPoint)
        
        self.addChild(player!)
    }
    
    override func didSimulatePhysics() {
        
        if let player = self.player {
            
            checkXPosition()
            changeSprite()
            
            if player.position.y < -40 {
                let vector = CGVector(dx: CGFloat.random(in: -self.size.width / 4...self.size.width / 4), dy: CGFloat.random(in: 500...700))
                    
                player.physicsBody?.applyImpulse(vector)
               
                
            } else if player.position.y > self.size.height + 100 {
                player.position.y = -40
                
            }
        }
    }
    
    
    private func checkXPosition() {
        if player!.position.x < -30 {
            player!.position.x = self.size.width + 30
        } else if player!.position.x > self.size.width + 30 {
            player!.position.x = -30
        }
    }
    
    private func changeSprite() {
        if !touched {
            if lastPositionX > player!.position.x {
                player!.changeTexture(way: .left)
            } else if lastPositionX < player!.position.x {
                player!.changeTexture(way: .right)
            }
            lastPositionX = player!.position.x
        }
    }
    
    private func createBackground() {
        
        while (levelBckgrnd <= self.size.height) {
            generateBackground()
            levelBckgrnd += Background.sizeY
        }
    }
    
    private func generateBackground() {
        var x: CGFloat = 0
        
        while (x < self.size.width) {
            let background = Background.populate(at: CGPoint(x: x, y: levelBckgrnd))
            x += Background.sizeX
            
            
            
            self.addChild(background)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "playgame" {
            let transition = SKTransition.fade(with: self.backgroundColor, duration: 0.5)
            let gameScene = GameScene(size: self.size)
            gameScene.scaleMode = .aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        }
        
        if node.name == "player" {
            player?.physicsBody?.velocity = CGVector.zero
            touched = true
            startPoint = node.position
        }
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "player" {
            
            touchesMovedArray.append(node.position)
            
            player?.physicsBody?.velocity = CGVector.zero
            player!.position.x = location.x
            player!.position.y = location.y
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let location = touches.first!.location(in: self)
        let node = self.atPoint(location)
        
        finishPoint = node.position
        
        if node.name == "player" {
            
            if touchesMovedArray.count > 6 {
                let finishPoint = touchesMovedArray[touchesMovedArray.count > 11 ? 10 : 5]
                let startPoint = touchesMovedArray[0]
                
                let vector = CGVector(dx: (finishPoint.x - startPoint.x) * 7, dy: (finishPoint.y - startPoint.y) * 10)
                
                player?.physicsBody?.applyImpulse(vector)
                
            } else {
                if let finishPoint = finishPoint, let startPoint = startPoint {
                    
                    let vector = CGVector(dx: (finishPoint.x - startPoint.x) * 7, dy: (finishPoint.y - startPoint.y) * 10)
                    player?.physicsBody?.applyImpulse(vector)
                }
                
            }
            touched = false
        }
        
        touchesMovedArray.removeAll()
        
    }
    
    static func takeBestScore() -> Int {
        if MenuScene.ud.value(forKey: MenuScene.bestScore) != nil {
            return MenuScene.ud.integer(forKey: MenuScene.bestScore)
        } else {
            return 0
        }
    }
    
    
}
