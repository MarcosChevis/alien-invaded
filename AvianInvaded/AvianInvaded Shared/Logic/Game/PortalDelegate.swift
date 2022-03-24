//
//  PortalDelegate.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 24/03/22.
//

import Foundation

protocol PortalDelegate: AnyObject {
    func teleport(to direction: RoomDirection)
}
