//
//  SKNode+ColisionGroup.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 16/03/22.
//

import Foundation
import SpriteKit

extension SKNode {
    var colisionGroup: ColisionGroup? {
        get {
            return ColisionGroup(rawValue: self.name ?? "")
        }
        set {
            self.name = newValue?.rawValue
        }
    }
}
