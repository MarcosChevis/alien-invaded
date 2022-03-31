//
//  SKNode+ColisionGroup.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 16/03/22.
//

import Foundation
import SpriteKit

extension SKNode {
    var colisionGroup: ColisionGroup? {
        get {
            return ColisionGroup(rawValue: self.name ?? "")
        }
        set {
            self.name = newValue?.rawValue
        }
    }
}

extension SKNode {
    func createTexture(_ name: String) -> [SKTexture] {
        let textureAtlas = SKTextureAtlas(named: name)
        var frames = [SKTexture]()
        for i in 0...textureAtlas.textureNames.count - 1 {
            let texture = textureAtlas.textureNamed(textureAtlas.textureNames[i])
            texture.filteringMode = .nearest
            frames.append(texture)
        }
        frames = frames.sorted { text1, text2 in
            text1.description < text2.description
        }
        return frames
    }
    
    func createCyclicalTexture(_ name: String) -> [SKTexture] {
        let frames = createTexture(name)
        var reversed = frames
        reversed.removeFirst()
        reversed = reversed.reversed()
        
        return frames + reversed
    }
}
