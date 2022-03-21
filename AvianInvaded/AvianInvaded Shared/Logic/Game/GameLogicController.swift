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
    private let roomBuilder: RoomBuilder
    private var tileSize: CGSize
    private let spawner: Spawner
    
    init(roomBuilder: RoomBuilder, spawner: Spawner = .init()) {
        self.currentRoom = .test
        self.spawner = spawner
        self.tileSize = .zero
        self.roomBuilder = roomBuilder
    }
    
    private var availableSpaces: [CGPoint] {
        currentRoom
            .colision
            .enumerated()
            .flatMap { y, row in
                row
                    .enumerated()
                    .compactMap { x, value in
                        if value == 1 {
                            return nil
                        }
                        return CGPoint(x: x, y: y)
                    }
            }
    }
    
    func buildNewRoom() -> SKNode {
        //SELECT NEW ROOM
        let roomNode = roomBuilder.build(room: currentRoom)
        
        if let tile = roomNode.children as? SKSpriteNode {
            tileSize = tile.size
        }
        
        return roomBuilder.build(room: currentRoom)
    }
    
    func spawnEnemies(sceneSize: CGSize) -> [SKNode] {
        let enemyInfo = selectEnemies()
        let spawnInfo = SpawnInfo(availablePositions: availableSpaces,
                                  tileSize: tileSize.width,
                                  enemySpawns: enemyInfo)
        
        
        return spawner.spawn(for: spawnInfo)
    }
    
    private func selectEnemies() -> [EnemySpawn] {
        let factories: [EnemyFactory] = [ChickenFactory()]
        let maxNumber = 10
        let enemyNumbers = generateEnemyNumbers(max: maxNumber, enemyTypeCount: factories.count)
        
        return factories.enumerated().map {index, factory in
            EnemySpawn(quantity: enemyNumbers[index], factory: factory)
        }
    }
    
    private func generateEnemyNumbers(max: Int, enemyTypeCount: Int) -> [Int] {
        if enemyTypeCount == 0 { return [] }
        if enemyTypeCount == 1 { return [max] }
        
        var currentMax = max
        
        return Array(repeating: 0, count: enemyTypeCount)
            .enumerated()
            .map { index, _ in
                if index == enemyTypeCount-1 {
                    return currentMax
                }
                
                let random = Int.random(in: 0...currentMax)
                currentMax -= random
                print("random: \(random) currentMax: \(currentMax) index \(index)")
                
                return random
            }
    }
    
    func update(_ currentTime: TimeInterval) {
    }
    
}
