//
//  Room.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 14/03/22.
//

import Foundation

struct Room {
    let tileSize: Double
    let tiles: [[Int]]
    let colision: [[Int]]
    let tilesName: [String]
    
    static let test: Room = Room(tileSize: 64,
                                 tiles: [
                                    [5, 1, 1, 1, 1, 1, 1, 8],
                                    [2, 9, 9, 9, 9, 9, 9, 4],
                                    [2, 9, 9, 9, 9, 9, 9, 4],
                                    [2, 9, 9, 9, 9, 9, 9, 4],
                                    [2, 9, 9, 9, 9, 9, 9, 4],
                                    [2, 9, 9, 9, 9, 9, 9, 4],
                                    [2, 9, 9, 9, 9, 9, 9, 4],
                                    [6, 3, 3, 3, 3, 3, 3, 7]
                                ],
                                 colision: [
                                    [1, 1, 1, 1, 1, 1, 1, 1],
                                    [1, 0, 0, 0, 0, 0, 0, 1],
                                    [1, 0, 0, 0, 0, 0, 0, 1],
                                    [1, 0, 0, 0, 0, 0, 0, 1],
                                    [1, 0, 0, 0, 0, 0, 0, 1],
                                    [1, 0, 0, 0, 0, 0, 0, 1],
                                    [1, 0, 0, 0, 0, 0, 0, 1],
                                    [1, 1, 1, 1, 1, 1, 1, 1]
                                ],
                                 tilesName: [
                                    "",
                                    "topWall",
                                    "leftWall",
                                    "bottomWall",
                                    "rightWall",
                                    "topLeftCorner",
                                    "bottomLeftCorner",
                                    "bottomRightCorner",
                                    "topRightCorner",
                                    "Floor"
                                 ])
}
