//
//  ConstantsEnum.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 15/03/22.
//

import Foundation
import CoreGraphics

enum GameConstants {
    static var forceMultiplier: CGFloat = 1
    
    static func updateForceMultiplaier(screenSize size: CGSize) {        
        forceMultiplier =  size.width / 1080
    }
}
