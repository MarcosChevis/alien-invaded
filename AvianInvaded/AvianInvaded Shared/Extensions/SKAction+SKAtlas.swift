//
//  SKAction+SKAtlas.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 28/03/22.
//

import Foundation
import SpriteKit

extension SKTexture {
    static func loadFromAtlas(named name: String) -> [SKTexture] {
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
    
    static func loadCyclicalFromAtlas(named name: String) -> [SKTexture] {
        let frames = loadFromAtlas(named: name)
        var reversed = frames
        reversed.removeFirst()
        reversed = reversed.reversed()
        
        
        return frames + reversed
    }
}
