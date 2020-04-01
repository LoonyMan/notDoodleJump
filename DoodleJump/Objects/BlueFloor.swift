//
//  BlueFloor.swift
//  DoodleJump
//
//  Created by Mihail on 15.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import SpriteKit

class BlueFloor: Floor {
    
    private let _texture = Textures.shared.blueFloor
    private let speedMove: CGFloat = 150
    
    init(at point: CGPoint) {
        super.init(texture: _texture)
        
        self.position.y = point.y
        
        self.run(startMove())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startMove() -> SKAction {
        
        let randomBool = Bool.random()
        
        let distance: CGFloat = UIScreen.main.bounds.width - 80
        let duration = distance / (speedMove * CGFloat.random(in: 0.7...1.3) )
        
        let leftMove = SKAction.moveTo(x: 40, duration: TimeInterval(duration))
        leftMove.timingMode = .easeInEaseOut
        let rightMove = SKAction.moveTo(x: UIScreen.main.bounds.width - 40, duration: TimeInterval(duration))
        rightMove.timingMode = .easeInEaseOut
        
        if randomBool {
            position.x = 40
        } else {
            position.x = UIScreen.main.bounds.width - 40
        }
        
        let movementSequence = randomBool ?
        SKAction.sequence([rightMove, leftMove]) :
        SKAction.sequence([leftMove, rightMove])
        
        self.run(SKAction.wait(forDuration: TimeInterval.random(in: 0...0.5)))
        
        let foreverMove = SKAction.repeatForever(movementSequence)
        
        return foreverMove
        
    }
}
