//
//  RoomBuilder.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 14/03/22.
//

import SpriteKit

final class RoomBuilder {
    private var cashedTiles: [Tile : SKSpriteNode]
    
    init() {
        cashedTiles = [:]
    }
    
    /**
     Receive a loaded Room Structure and transform into SpriteKit Nodes
        - Parameters:
            - room: A room data structure containing tile size, position and colision
        - Returns:
            A SK node containing all the configured and positioned SKSpriteNodes
     */
    func build(room: Room) -> SKNode {
        
        
        return SKNode()
    }
    private func buildTile(for tile: Tile) -> SKSpriteNode { return SKSpriteNode() }
    private func setupTilePhysics(for tile: SKSpriteNode) {}
}
