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
    
    func buildNewRoom(portalDelegate: PortalDelegate?) -> SKNode {
        let directions = roomRepository.currentRoomAvailableDirections
        return builder.build(room: currentRoom, availableDirections: directions, portalDelegate: portalDelegate)
    }
    
    func nextRoom(direction: RoomDirection, portalDelegate: PortalDelegate?) -> SKNode {
        let room = roomRepository.nextRoom(direction: direction)
        return builder.build(room: room, availableDirections: roomRepository.currentRoomAvailableDirections, portalDelegate: portalDelegate)
    }
    
    func tileSize(forScreen screenSize: CGSize) -> CGSize {
        return builder.scaleToScreen(sceneWidth: screenSize.width, imageSize: CGSize(width: currentRoom.tileSize, height: currentRoom.tileSize))
    }
    
}
