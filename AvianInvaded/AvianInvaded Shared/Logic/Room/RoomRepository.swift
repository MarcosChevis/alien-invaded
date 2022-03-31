//
//  RoomRepository.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation
import CoreGraphics

final class RoomRepository {
    private let availableRooms: [Room]
    private let currentRoomIndex: Int
    private var currentRoomPosition: CGPoint
    private var dungeonMatrix: [[Int]]
    
    init(fileName: String = "rooms") {
        self.currentRoomIndex = 0
        self.currentRoomPosition = .zero
        self.dungeonMatrix = []
        self.availableRooms = JSONDecoder.decode(to: [Room].self, from: fileName) ?? []
    }
    
    var currentRoom: Room {
         availableRooms[dungeonMatrix[currentRoomPosition.intY][currentRoomPosition.intX]]
    }
    
    var currentRoomAvailableDirections: [RoomDirection] {
        var directions: [RoomDirection] = []
        if dungeonMatrix[currentRoomPosition.intY - 1][currentRoomPosition.intX] != -1 {
            directions.append(.top)
        }
        if dungeonMatrix[currentRoomPosition.intY + 1][currentRoomPosition.intX] != -1 {
            directions.append(.bottom)
        }
        if dungeonMatrix[currentRoomPosition.intY][currentRoomPosition.intX - 1] != -1 {
            directions.append(.left)
        }
        if dungeonMatrix[currentRoomPosition.intY][currentRoomPosition.intX + 1] != -1 {
            directions.append(.right)
        }
        return directions
    }
    /**
     Start the mapGeneration and assign the current Room
     */
    func startup() {
        dungeonMatrix = generateDungeon(totalRooms: 10)
    }
    
    func nextRoom(direction: RoomDirection) -> Room {
        currentRoomPosition += direction.point
        
        if dungeonMatrix[currentRoomPosition.intY][currentRoomPosition.intX] == -1 {
            fatalError("ERROR")
        }
        
        return currentRoom
    }
    
    private func printMatrix(matrix: [[Int]]) {
        var string = ""
        
        for (line) in matrix {
            string += "["
            for (item) in line {
                if item < 0 {
                    string += "."
                } else if item >= 0 && item < 10 {
                    string += "\(item)"
                } else if item >= 10 {
                    string += "\(item)"
                }
                string += " "
            }
            string += "]\n"
        }
        print(string)
    }
    
    private func generateDungeon(totalRooms: Int) -> [[Int]] {
        var matrix: [[Int]] = Array(repeating: Array(repeating: -1, count: totalRooms),
                                    count: totalRooms)
        var lastDirection: RoomDirection = .top
        
        let midPoint = ((totalRooms)/2)-1
        var currentPosition: CGPoint = CGPoint(x: midPoint, y: midPoint)
        
        var count = 0
        
        while count < totalRooms {
            let room = getRandomRoom(lastDirection: lastDirection)
            let direction = getRandomDirection(currentPosition: currentPosition,
                                               totalRooms: totalRooms,
                                               lastDirection: lastDirection,
                                               possibleDirections: room.availableExits)
            
            currentPosition += direction.point
            lastDirection = direction
            
            if matrix[currentPosition.intY][currentPosition.intX] == -1 {
                matrix[currentPosition.intY][currentPosition.intX] = room.id
                if count == 0 {
                    currentRoomPosition = currentPosition
                }
                count += 1
            }
        }
        
        return matrix
    }
    
    private func getRandomRoom(lastDirection: RoomDirection) -> Room {
        let filteredRooms = availableRooms.filter { room in
            room.availableExits.contains(!lastDirection)
        }
        
        return filteredRooms.randomElement() ?? availableRooms[0]
    }
    
    private func getRandomDirection(currentPosition: CGPoint,
                                    totalRooms: Int,
                                    lastDirection: RoomDirection,
                                    possibleDirections: [RoomDirection]) -> RoomDirection {
        var direction = possibleDirections.randomElement() ?? possibleDirections[0]
        
        while isDirectionInValid(currentPosition: currentPosition,
                                 totalRooms: totalRooms,
                                 lastDirection: lastDirection.point,
                                 direction: direction.point) {
            direction = possibleDirections.randomElement() ?? possibleDirections[0]
        }
        
        return direction
    }
    
    private func isDirectionInValid(currentPosition: CGPoint,
                                    totalRooms: Int,
                                    lastDirection: CGPoint,
                                    direction: CGPoint) -> Bool {
        let isRoomXAxisOutOfBounds = currentPosition.intX + direction.intX >= totalRooms
        || currentPosition.intX + direction.intX < 0
        let isRoomYAxisOutOfBounds = currentPosition.intY + direction.intY >= totalRooms
        || currentPosition.intY + direction.intY < 0
        let isDirectionInvertOfPrevious = direction == lastDirection * -1
        
        return isRoomXAxisOutOfBounds || isRoomYAxisOutOfBounds || isDirectionInvertOfPrevious
    }
    
}
