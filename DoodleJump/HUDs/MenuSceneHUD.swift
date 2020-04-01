//
//  HUDmenuScene.swift
//  DoodleJump
//
//  Created by Mihail on 14.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import SpriteKit

class MenuSceneHUD {
    
    static func populatePlayer(at point: CGPoint) -> Player {
        let player = Player.populate(at: point)
        player.zPosition = 5
        
        
        return player
    }
    
    static func populateBackground(screenshot: UIImage) -> SKEffectNode {
        let texture = SKTexture(image: screenshot)
        let background = SKSpriteNode(texture: texture)
        
        background.zPosition = 0
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.position = CGPoint(x: 0, y: 0)
        
        let effect: SKEffectNode = SKEffectNode()
        let filter: CIFilter = CIFilter(name:"CIGaussianBlur")!
        
        filter.setValue(10, forKey: "inputRadius")
        effect.filter = filter
        effect.addChild(background)
        
        return effect
        
    }
    
    static func populateScoreLabel(score: String) -> SKLabelNode {
        
        let scoreLabel = SKLabelNode(text: "GG WP! Your score is \(score)")
        scoreLabel.fontSize = 20
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontColor = .darkText
        
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.horizontalAlignmentMode = .center
        
        scoreLabel.zPosition = 90
        scoreLabel.position = CGPoint(x: MenuScene.screenSize.width / 2, y: MenuScene.screenSize.height * 0.7)
        
        return scoreLabel
        
    }
    
    static func populateBestScoreLabel(bestscore: String) -> SKLabelNode {
        
        let scoreLabel = SKLabelNode(text: "Best score is \(bestscore)")
        scoreLabel.fontSize = 30
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontColor = .darkText
        
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.horizontalAlignmentMode = .center
        
        scoreLabel.zPosition = 90
        scoreLabel.position = CGPoint(x: MenuScene.screenSize.width / 2, y: MenuScene.screenSize.height * 0.7 - 30)
        
        return scoreLabel
        
    }
    
    static func populatePlayGameButton() -> SKSpriteNode {
        
        let texture = SKTexture(imageNamed: "play")
        let button = SKSpriteNode(texture: texture)
        button.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 3)
        button.name = "playgame"
        button.zPosition = 99
        
        return button
    }

}
