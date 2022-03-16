//
//  Contactable.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 16/03/22.
//

import Foundation
import SpriteKit

protocol Contactable {
    func contact(with colisionGroup: ColisionGroup)
}
