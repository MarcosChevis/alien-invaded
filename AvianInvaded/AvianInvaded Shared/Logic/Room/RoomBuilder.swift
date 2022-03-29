//
//  RoomBuilder.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 14/03/22.
//

import SpriteKit

final class RoomBuilder {
    private var cashedTiles: [Int: SKSpriteNode]
    private var sceneSize: CGSize
    init(sceneSize: CGSize) {
        cashedTiles = [:]
        self.sceneSize = sceneSize
    }
    
    /**
     Receive a loaded Room Structure and transform into SpriteKit Nodes
     - Parameters:
     - room: A room data structure containing tile size, position and colision
     - Returns:
     A SKNode containing all the configured and positioned SKSpriteNodes
     */
    func build(room: Room, availableDirections: [RoomDirection], portalDelegate: PortalDelegate?) -> SKNode {
        let node = SKNode()
        let spriteSize = scaleToScreen(sceneWidth: sceneSize.width,
                                       imageSize: CGSize(width: room.tileSize,
                                                         height: room.tileSize))
        let tiles = room
            .tiles
            .map { row in
                row.map { rawvalue -> SKSpriteNode in
                    let sprite = buildTile(for: rawvalue, size: spriteSize, tilesName: room.tilesName)
                    sprite.anchorPoint = CGPoint(x: 0, y: 1)
                    node.addChild(sprite)
                    sprite.colisionGroup = .environment
                    return sprite
                }
            }
        
        buildDecorations(for: room.decoration,
                         tileSize: spriteSize,
                         gridSize: CGSize(width: room.tiles[0].count, height: room.tiles.count),
                         spriteSize: spriteSize,
                         availableDirections: availableDirections,
                         portalDelegate: portalDelegate
        )
        .forEach { sprite in
            node.addChild(sprite)
            sprite.zPosition = 3
        }
        
        node.colisionGroup = .environment
        positionTiles(tiles, tileSize: spriteSize)
        setupTilesPhysics(for: tiles, colisionMatrix: room.colision)
        cashedTiles = [:]
        return node
    }
    
    private func buildTile(for tile: Int, size: CGSize, tilesName: [String]) -> SKSpriteNode {
        let tileSprite: SKSpriteNode
        
        if let cashedTile = self.cashedTiles[tile], let tileCopy = cashedTile.copy() as? SKSpriteNode {
            tileSprite = tileCopy
        } else {
            let texture = SKTexture(imageNamed: tilesName[tile])
            texture.filteringMode = .nearest
            tileSprite = SKSpriteNode(texture: texture, color: SKColor.clear, size: size)
            cashedTiles[tile] = tileSprite
        }
        
        return tileSprite
    }
    
    private func positionTiles(_ tiles: [[SKSpriteNode]], tileSize: CGSize) {
        for (row, tileRow) in tiles.enumerated() {
            for (column, tile) in tileRow.enumerated() {
                tile.position = CGPoint(x: (tileSize.width * Double(column)),
                                        y: (tileSize.height * Double(tileRow.count - row)))
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
    
    // swiftlint:disable function_parameter_count
    private func buildDecorations(for decorations: [DecorationInfo],
                                  tileSize: CGSize,
                                  gridSize: CGSize,
                                  spriteSize: CGSize,
                                  availableDirections: [RoomDirection],
                                  portalDelegate: PortalDelegate?
    ) -> [SKNode] {
        decorations.compactMap { decorationInfo in
            let position = CGPoint(x: (CGFloat(decorationInfo.position.x+1) * tileSize.width),
                                   y: ((gridSize.height - CGFloat(decorationInfo.position.y))
                                       * tileSize.height))
            
            let node = buildDecoration(decoration: decorationInfo.decoration,
                                       spriteSize: spriteSize,
                                       availableDirections: availableDirections,
                                       portalDelegate: portalDelegate)
            
            node?.position = position
            return node
        }
    }
    
    private func buildDecoration(decoration: Decoration,
                                 spriteSize: CGSize,
                                 availableDirections: [RoomDirection],
                                 portalDelegate: PortalDelegate?
    ) -> SKNode? {
        switch decoration {
        case .portal(let direction):
            guard availableDirections.contains(direction) else { return nil }
            let portal = Portal(direction: direction, spriteSize: spriteSize)
            portal.delegate = portalDelegate
            return portal
        }
    }
    
    private func setupTilePhysics(for tile: SKSpriteNode) {
        
        let physicsBody = SKPhysicsBody(rectangleOf: tile.size,
                                        center: CGPoint(x: tile.size.width/2,
                                                        y: -tile.size.height/2))
        tile.physicsBody = physicsBody
        physicsBody.affectedByGravity = false
        physicsBody.isResting = true
        physicsBody.isDynamic = false
        
        physicsBody.collisionBitMask = ColisionGroup.getCollisionMask( tile.colisionGroup)
        physicsBody.contactTestBitMask = ColisionGroup.getContactMask( tile.colisionGroup)
        physicsBody.categoryBitMask = ColisionGroup.getCategotyMask( tile.colisionGroup)
    }
    
    func scaleToScreen(sceneWidth: CGFloat, imageSize: CGSize) -> CGSize {
        let scale = 0.08
        let w = sceneWidth * scale
        let h = w * imageSize.height / imageSize.width
        let size = CGSize(width: w, height: h)
        
        return size
    }
}
