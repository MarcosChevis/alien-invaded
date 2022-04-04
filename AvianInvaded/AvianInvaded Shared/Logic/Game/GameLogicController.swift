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
    weak var coordinator: GameCoordinatorProtocol?
    private let roomService: RoomService
    private var tileSize: CGSize
    private var difficultyMultiplier: Double = 0.9
    private var score: Int = 0
    private var enemyCount: Int
    private var isGameOver: Bool = false
    private let spawner: Spawner
    
    init(roomService: RoomService, spawner: Spawner = .init()) {
        self.spawner = spawner
        self.tileSize = .zero
        self.enemyCount = 0
        self.roomService = roomService
    }
    
    func getplayerStartPosition(forScreen screenSize: CGSize) -> CGPoint {
        let tilePos = roomService.currentRoom.startPosition
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
        difficultyMultiplier += 0.1
        let enemyInfo = selectEnemies(factories: [FlamingoFactory(multiplier: difficultyMultiplier),
                                                  ChickenFactory(multiplier: difficultyMultiplier)],
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
        
        score += Int(100 * difficultyMultiplier)
        gameLogicDelegate?.enemyKilled()
    }
}

extension GameLogicController: PlayerStateDelegate {
    func playerDidDie() {
        if !isGameOver {
            coordinator?.gameOver(score: score)
            isGameOver = true
            gameLogicDelegate?.gameOver()
        }
    }
    
    func playerDidUpgrade() {
        print("Player Upgraded")
    }
    
}

extension GameLogicController: GameNavigationDelegate {
    func restartGame() {
        score = 0
        difficultyMultiplier = 1
        isGameOver = false
        roomService.startUp()
        gameLogicDelegate?.restart()
    }
}
