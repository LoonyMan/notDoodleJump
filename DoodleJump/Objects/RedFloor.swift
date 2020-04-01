//
//  File.swift
//  DoodleJump
//
//  Created by Mihail on 15.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import SpriteKit

class RedFloor: Floor {
    
    private let _texture = Textures.shared.redFloor
    
    init(at point: CGPoint) {
        super.init(texture: _texture)
        
        self.position = point
        
        self.physicsBody?.categoryBitMask = BitMaskCategory.redFloor
    }
    
    static func remove() {
        print("TTT")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
