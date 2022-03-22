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
    private let roomService: RoomService
    private var tileSize: CGSize
    private let spawner: Spawner
    
    init(roomService: RoomService, spawner: Spawner = .init()) {
        self.spawner = spawner
        self.tileSize = .zero
        self.roomService = roomService
    }
    
    func buildNewRoom() -> SKNode {
        //SELECT NEW ROOM
        let roomNode = roomService.buildNewRoom()
        
        if let tile = roomNode.children.first as? SKSpriteNode {
            tileSize = tile.size
        }
        
        return roomNode
    }
    
    func spawnEnemies() -> [SKNode] {
        let enemyInfo = selectEnemies(factories: [ChickenFactory()],
                                      maxEnemyCount: roomService.currentRoom.enemyNumber)
        let spawnInfo = SpawnInfo(availablePositions: roomService.currentRoom.availableSpaces,
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
