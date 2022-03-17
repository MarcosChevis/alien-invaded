//
//  SKSpriteNode+Scale.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 16/03/22.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func scaleToScreen(scale: CGFloat) -> CGSize {
        guard let sceneWidth = self.scene?.size.width else { return .zero }
        guard let imageSize = self.texture?.size() else { return .zero }
                
        let w = sceneWidth * scale
        let h = w * imageSize.height / imageSize.width
        
        let size = CGSize(width: w, height: h)
        
        
        return size
    }
}


