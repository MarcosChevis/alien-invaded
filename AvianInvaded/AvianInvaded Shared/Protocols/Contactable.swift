//
//  Contactable.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 16/03/22.
//

import Foundation
import SpriteKit

protocol Contactable: AnyObject {
    var damage: CGFloat? { get }
    func contact(with colisionGroup: ColisionGroup, damage: CGFloat?)
}

extension Contactable {
    var damage: CGFloat? {
        return nil
    }
}
