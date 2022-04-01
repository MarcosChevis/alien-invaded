//
//  GameLogicController.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation
import SpriteKit

class GameLogicController {
    
    weak var gameLogicDelegate: GameLogicDelegate?
    private let roomService: RoomService
    private var tileSize: CGSize
    private var enemyCount: Int
    private let spawner: Spawner
    
    init(roomService: RoomService, spawner: Spawner = .init()) {
        self.spawner = spawner
        self.tileSize = .zero
        self.enemyCount = 0
        self.roomService = roomService
    }
    
    func getplayerStartPosition(forScreen screenSize: CGSize) -> CGPoint {
        let tilePos = roomService.currentRoom.startPosition
        print("Player Position", tilePos)
        let tileSize = roomService.tileSize(forScreen: screenSize)
        
        return CGPoint(x: tileSize.width * CGFloat(tilePos.x),
                       y: tileSize.height * CGFloat(tilePos.y))
    }
    
    func buildNewRoom() -> SKNode {
        let roomNode = roomService.buildNewRoom(portalDelegate: self)
        if let tile = roomNode.children.first as? SKSpriteNode {
            tileSize = tile.size
        }
        
        return roomNode
    }
    
    func spawnEnemies() -> [SKNode] {
        let enemyInfo = selectEnemies(factories: [FlamingoFactory(), ChickenFactory()],
                                      maxEnemyCount: roomService.currentRoom.enemyNumber)
        let spawnInfo = SpawnInfo(availablePositions: roomService.currentRoom.availableSpaces,
                                  tileSize: tileSize.width,
                                  enemySpawns: enemyInfo)
        
        let enemies = spawner.spawn(for: spawnInfo, delegate: self)
        enemyCount = enemies.count
        
        return enemies
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

extension GameLogicController: PortalDelegate {
    func teleport(to direction: RoomDirection) {
        let newRoom = roomService.nextRoom(direction: direction, portalDelegate: self)
        gameLogicDelegate?.teleport(to: newRoom)
    }
}

extension GameLogicController: EnemyDelegate {
    func enemyWasDefeatead() {
        enemyCount -= 1
        
        if enemyCount == 0 {
            NotificationCenter
                .default
                .post(name: .shouldActivatePortals,
                      object: nil)
        }
    }
}
