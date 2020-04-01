//
//  WhiteFloor.swift
//  DoodleJump
//
//  Created by Mihail on 15.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import SpriteKit

class WhiteFloor: Floor {
    
    private var _texure = Textures.shared.whiteFloor
    
    init(at point: CGPoint) {
        super.init(texture: _texure)
        
        self.position = point
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
