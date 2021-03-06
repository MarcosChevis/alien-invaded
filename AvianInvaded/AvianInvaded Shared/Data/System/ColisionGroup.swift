//
//  ColisionGroup.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 14/03/22.
//

import Foundation

enum ColisionGroup: String {
    case environment
    case player
    case enemy
    case playerProjectile
    case enemyProjectile
    case enemyMeleeAttack
    case neutralProjectile
    case portal
    case light
    
    static func getCollisionMask(_ colisionGroup: ColisionGroup?) -> UInt32 {
        switch colisionGroup {
        case .environment:
            return (  getCategotyMask(.player)
                      | getCategotyMask(.enemy))
        case .player:
            return (  getCategotyMask(.enemy)
                      | getCategotyMask(.environment))
        case .enemy:
            return (  getCategotyMask(.player)
                      | getCategotyMask(.enemy)
                      | getCategotyMask(.environment))
        case .playerProjectile:
            return 0b0
        case .enemyProjectile:
            return 0b0
        case .enemyMeleeAttack:
            return 0b0
        case .neutralProjectile:
            return 0b0
        case .portal:
            return 0b0
        case .light:
            return 0b0
        case .none:
            return 0b0
        }
    }
    
    static func getContactMask(_ colisionGroup: ColisionGroup?) -> UInt32 {
        
        switch colisionGroup {
        case .environment:
            return 0b0
        case .player:
            return (  getCategotyMask(.neutralProjectile)
                      | getCategotyMask(.enemy)
                      | getCategotyMask(.enemyProjectile)
                      | getCategotyMask(.portal)
                      | getCategotyMask(.enemyMeleeAttack))
                    
        case .enemy:
            return (  getCategotyMask(.neutralProjectile)
                      | getCategotyMask(.player)
                      | getCategotyMask(.playerProjectile))
        case .playerProjectile:
            return (  getCategotyMask(.environment)
                      | getCategotyMask(.enemy))
        case .enemyProjectile:
            return (  getCategotyMask(.environment)
                      | getCategotyMask(.player))
        case .enemyMeleeAttack:
            return( getCategotyMask(.player))
        case .neutralProjectile:
            return (  getCategotyMask(.environment)
                      | getCategotyMask(.player)
                      | getCategotyMask(.enemy))
        case .portal:
            return (getCategotyMask(.player))
        case .light:
            return 0b0
        case .none:
            return 0b0
        }
        
    }
    
    static func getLightMask(_ colisionGroup: ColisionGroup?) -> UInt32 {
        return getCategotyMask(.light) | getCategotyMask(.portal)
    }
    
    static func getCategotyMask(_ colisionGroup: ColisionGroup?) -> UInt32 {
        
        switch colisionGroup {
        case .environment:
            return (1 << 1)
        case .player:
            return (1 << 2)
        case .enemy:
            return (1 << 3)
        case .playerProjectile:
            return (1 << 4)
        case .enemyProjectile:
            return (1 << 5)
        case .enemyMeleeAttack:
            return (1 << 6)
        case .neutralProjectile:
            return (1 << 7)
        case .portal:
            return (1 << 8)
        case .light:
            return (1 << 9)
        case .none:
            return 0b0
        }
    }
}
