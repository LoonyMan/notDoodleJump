
import SpriteKit
import GameplayKit
import CoreMotion
import UIKit

class GameScene: SKScene {
    
    var scoreLabel: SKLabelNode!
    
    var maxPlayerHeightForCam: CGFloat = UIScreen.main.bounds.size.height / 2
    var lastHeight: CGFloat = 0
    var lastPositionX: CGFloat = UIScreen.main.bounds.size.width / 2
    var levelFloor: CGFloat = 200
    var levelBckgrnd: CGFloat = -100
    var xAcceleration: CGFloat = 0
    
    var onFloor = false
    
    let motionManager = CMMotionManager()
    
    let screenSize = UIScreen.main.bounds.size
    
    var player: Player!
    let myCamera = SKCameraNode()
    
    var loading = true
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        setupCamera()
        setupLabelScore()
        createBottomFloor()
        
        let deadline = DispatchTime.now() + .nanoseconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadline) { [unowned self] in
            
            self.setupPlayer(at: CGPoint(x: self.screenSize.width / 2, y: 100))
            
            self.createBackground()
            self.createFloors()
            self.generateLvl()
        }
        
    }
    
    override func didSimulatePhysics() {
        
        
        checkXPosition()
        checkYPosition()
        changeSprite()
        removeInvisibleObj()
        moveCamera()
        moveScoreLabel()
        
        generateLvl()
        
    }
    
    private func generateLvl() {
        
        if player.position.y >= levelFloor - screenSize.height {
            
            createFloors()
        }
        
        if player.position.y >= levelBckgrnd - screenSize.height {
            
            createBackground()
        }
    }
    
    private func setupLabelScore() {
        scoreLabel = GameSceneHUD.createScoreLabel()
        
        scoreLabel.position = CGPoint(x: screenSize.width - 10, y: camera!.position.y + screenSize.height * 0.5 - 10)
        
        addChild(scoreLabel)
    }
    
    private func createBottomFloor() {
        let x = Int(self.size.width + 60)
        for i in 0...x where i % 100 == 0 {
            spawnFloor(at: CGPoint(x: i, y: 80))
        }
    }
    
    private func createBackground() {
        while (levelBckgrnd <= player.position.y + screenSize.height) {
            generateBackground()
            levelBckgrnd += Background.sizeY
        }
    }
    
    private func createFloors() {
        
        while levelFloor <= player.position.y + screenSize.height {
            
            spawnFloor(at: CGPoint(x: CGFloat.random(in: 45...screenSize.width - 45), y: levelFloor + CGFloat.random(in: -15...15)))
            levelFloor += 100
        }
    }
    

    private func checkYPosition() {
        if player.position.y < lastHeight {
            player.set(toucheble: true)
            lastHeight = player.position.y
            if player.position.y < camera!.position.y - screenSize.height * 0.6 - player.size.height {
                
                self.isPaused = true
                
                self.scoreLabel.removeFromParent()
                
                let deadline = DispatchTime.now() + .nanoseconds(1)
                DispatchQueue.main.asyncAfter(deadline: deadline) { [unowned self] in
                    let transition = SKTransition.crossFade(withDuration: 0.5)
                    let menuScene = MenuScene(size: self.size)
                    menuScene.scaleMode = .aspectFill
                    
                    menuScene.screenShot = self.view?.pb_takeSnapshot()
                    menuScene.score = self.scoreLabel.text
                    
                    self.saveBestScore(score: Int(self.scoreLabel.text!)!)
                    
                    self.scene!.view?.presentScene(menuScene, transition: transition)
                }
                
                
                
                
            }
        } else { lastHeight = player.position.y }
        
    }
    
    private func checkXPosition() {
        player.position.x += xAcceleration * 50
        if player.position.x < -40 {
            player.position.x = self.size.width + 40
        } else if player.position.x > self.size.width + 40 {
            player.position.x = -40
        }
        
    }
    
    private func changeSprite() {
        if lastPositionX > player.position.x {
            player.changeTexture(way: .left)
        } else if lastPositionX < player.position.x {
            player.changeTexture(way: .right)
        }
        lastPositionX = player.position.x
    }
    
    private func moveCamera() {
        if player.position.y - screenSize.height * 0.1 > maxPlayerHeightForCam {
            camera?.position.y = maxPlayerHeightForCam
            maxPlayerHeightForCam = player.position.y - screenSize.height * 0.1
        }
        scoreLabel.text = "\(Int(maxPlayerHeightForCam/100) - 3)"
    }
    
    private func moveScoreLabel() {
        scoreLabel.position = CGPoint(x: screenSize.width - 10, y: camera!.position.y + screenSize.height * 0.5 - 10)
    }
    
    private func removeInvisibleObj() {
        enumerateChildNodes(withName: "floor") { (node, stop) in
            if node.position.y < self.camera!.position.y - self.screenSize.height / 2 {
                node.removeFromParent()
            }
        }
        enumerateChildNodes(withName: "background") { (node, stop) in
            if node.position.y < self.camera!.position.y - self.screenSize.height {
                node.removeFromParent()
            }
        }
    }
    
}
