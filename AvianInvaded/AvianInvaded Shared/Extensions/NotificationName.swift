//
//  NotificationName.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 21/03/22.
//

import Foundation

extension Notification.Name {
    static var playerDidMove: Notification.Name {
        .init(rawValue: "player.didMove")
    }
    
    static var playerDidRotate: Notification.Name {
        .init(rawValue: "player.didRotate")
    }
}
