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
    
    static let test: Room = Room(tileSize: 32,
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
                                ])
}
