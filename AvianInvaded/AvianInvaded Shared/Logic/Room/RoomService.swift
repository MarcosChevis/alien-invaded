//
//  RoomService.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation
import SpriteKit

final class RoomService {
    private let builder: RoomBuilder
    private let roomRepository: RoomRepository
    private(set) var currentRoomDifficulty: RoomDifficulty
    
    init(builder: RoomBuilder, roomRepository: RoomRepository, currentRoomDifficulty: RoomDifficulty = .standard) {
        self.builder = builder
        self.roomRepository = roomRepository
        self.currentRoomDifficulty = currentRoomDifficulty
        roomRepository.startup()
    }
    
    var currentRoom: Room { roomRepository.currentRoom }
    
    func buildNewRoom() -> SKNode {
        builder.build(room: currentRoom)
    }
    
    
}
