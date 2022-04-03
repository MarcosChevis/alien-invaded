//
//  FlamingoAttackNode.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 01/04/22.
//

import Foundation
import SpriteKit

class FlamingoAttackNode: SKNode, LifeCycleElement {
    var damage: CGFloat?
    
    init(damage: CGFloat) {
        self.damage = damage
        super.init()
        colisionGroup = .enemyMeleeAttack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FlamingoAttackNode: Contactable {
    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?) {
       return
    }
}
