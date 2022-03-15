//
//  RoomBuilder.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 14/03/22.
//

import SpriteKit

final class RoomBuilder {
    private var cashedTiles: [Int : SKSpriteNode]
    
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
        let node = SKNode()
        let tiles = room
            .tiles
            .map { row in
                row.map { rawvalue -> SKSpriteNode in
                    let sprite = buildTile(for: rawvalue, size: room.tileSize, tilesName: room.tilesName)
                    sprite.anchorPoint = CGPoint(x: 0, y: 1)
                    node.addChild(sprite)
                    sprite.name = "wall"
                    return sprite
                }
            }
        positionTiles(tiles, tileSize: room.tileSize)
        setupTilesPhysics(for: tiles, colisionMatrix: room.colision)
        cashedTiles = [:]
        return node
    }
    
    private func buildTile(for tile: Int, size: Double, tilesName: [String]) -> SKSpriteNode {
        let tileSprite: SKSpriteNode
        
        if let cashedTile = self.cashedTiles[tile], let tileCopy = cashedTile.copy() as? SKSpriteNode {
            tileSprite = tileCopy
        } else {
            let texture = SKTexture(imageNamed: tilesName[tile])
            tileSprite = SKSpriteNode(texture: texture, color: SKColor.clear, size: CGSize(width: size, height: size))
            cashedTiles[tile] = tileSprite
        }
        
        return tileSprite
    }
    
    private func positionTiles(_ tiles: [[SKSpriteNode]], tileSize: Double) {
        for (row, tileRow) in tiles.enumerated() {
            for (column, tile) in tileRow.enumerated() {
                tile.position = CGPoint(x: (tileSize * Double(column)), y: (tileSize * Double(tileRow.count - row)))
            }
        }
    }
    
    private func setupTilesPhysics(for tiles: [[SKSpriteNode]], colisionMatrix: [[Int]]) {
        for (row, tileRow) in tiles.enumerated() {
            for (column, tile) in tileRow.enumerated() {
                if colisionMatrix[row][column] == 1 {
                    setupTilePhysics(for: tile)
                }
            }
        }
    }
    
    private func setupTilePhysics(for tile: SKSpriteNode) {
        
        let physicsBody = SKPhysicsBody(rectangleOf: tile.size, center: CGPoint(x: tile.size.width/2, y: -tile.size.height/2))
        tile.physicsBody = physicsBody
        physicsBody.affectedByGravity = false
        physicsBody.collisionBitMask = 0
        physicsBody.isResting = true
        physicsBody.categoryBitMask = 1
        
    }
}

struct PhysicsCategory {
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let block : UInt32 = 0b1
    
}
