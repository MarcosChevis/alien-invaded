//
//  Decoration.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 23/03/22.
//

import Foundation

struct DecorationInfo: Codable {
    let position: Point
    let decoration: Decoration
}

enum Decoration: Codable {
    case portal(direction: RoomDirection)
}
