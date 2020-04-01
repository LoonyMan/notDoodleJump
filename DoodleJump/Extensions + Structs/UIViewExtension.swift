//
//  UIImageExtension.swift
//  DoodleJump
//
//  Created by Mihail on 14.03.2020.
//  Copyright © 2020 Mihail. All rights reserved.
//

import UIKit

extension UIView {

    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
