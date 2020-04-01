
//
//  Textures.swift
//  DoodleJump
//
//  Created by Mihail on 15.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import SpriteKit

class Textures {
    static let shared = Textures()
    // #MARK: player
    let leftJump = SKTexture(imageNamed: "leftSeat")
    let leftStay = SKTexture(imageNamed: "leftStay")
    let rightJump = SKTexture(imageNamed: "rightSeat")
    let rightStay = SKTexture(imageNamed: "rightStay")
    // #MARK: background
    let background = SKTexture(imageNamed: "background")
    let greenBackground = SKTexture(imageNamed: "greenBackground")
    // #MARK: floor
    let whiteFloor = SKTexture(imageNamed: "whiteFloor")
    let redFloor = SKTexture(imageNamed: "redFloor")
    let blueFloor = SKTexture(imageNamed: "blueFloor")
    
    func preload() {
        print("Textures is preloaded!")
        
        leftJump.preload {}
        leftStay.preload {}
        rightJump.preload {}
        rightStay.preload {}
        
        background.preload {}
        greenBackground.preload {}
        
        whiteFloor.preload {}
        redFloor.preload {}
        blueFloor.preload {}
    }
}
