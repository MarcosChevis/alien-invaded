//
//  GameLogicController.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation
import GameplayKit
import CoreGraphics
import SpriteKit

class GameLogicController {
    
    weak var gameLogicDelegate: GameLogicDelegate?
    private var currentRoom: Room
    private var currentRoomDifficulty: RoomDifficulty
    private let roomBuilder: RoomBuilder
    private var tileSize: CGSize
    private let spawner: Spawner
    
    init(roomBuilder: RoomBuilder, spawner: Spawner = .init()) {
        self.currentRoom = .test
        self.currentRoomDifficulty = .standard
        self.spawner = spawner
        self.tileSize = .zero
        self.roomBuilder = roomBuilder
    }
    
    func buildNewRoom() -> SKNode {
        //SELECT NEW ROOM
        let roomNode = roomBuilder.build(room: currentRoom)
        
        if let tile = roomNode.children.first as? SKSpriteNode {
            tileSize = tile.size
        }
        
        return roomBuilder.build(room: currentRoom)
    }
    
    func spawnEnemies() -> [SKNode] {
        let enemyInfo = selectEnemies(factories: [ChickenFactory()], maxEnemyCount: currentRoom.enemyNumber)
        let spawnInfo = SpawnInfo(availablePositions: currentRoom.availableSpaces,
                                  tileSize: tileSize.width,
                                  enemySpawns: enemyInfo)
        
        
        return spawner.spawn(for: spawnInfo)
    }
    
    private func selectEnemies(factories: [EnemyFactory], maxEnemyCount: Int) -> [EnemySpawn] {
        let enemyNumbers = Int.randomList(maxValue: maxEnemyCount,
                                          listSize: factories.count)
        
        return factories.enumerated().map {index, factory in
            EnemySpawn(quantity: enemyNumbers[index], factory: factory)
        }
    }
    
    func update(_ currentTime: TimeInterval) {
    }
    
}
