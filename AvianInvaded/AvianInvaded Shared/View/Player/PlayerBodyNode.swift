//
//  PlayerBodyNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 24/03/22.
//

import Foundation
import SpriteKit

class PlayerBodyNode: SKNode, Contactable {
    
    weak var contactDelegate: Contactable?
    
    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
        contactDelegate?.contact(with: colisionGroup, damage: damage)
    }
    
}
