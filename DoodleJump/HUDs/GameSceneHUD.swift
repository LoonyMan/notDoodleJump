//
//  HUD.swift
//  DoodleJump
//
//  Created by Mihail on 13.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import SpriteKit

class GameSceneHUD {
    
    static func createScoreLabel() -> SKLabelNode {
        let scoreLabel = SKLabelNode(text: "0")
        
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.zPosition = 99
        scoreLabel.fontSize = 15
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontColor = .black
        
        return scoreLabel
    }
}
