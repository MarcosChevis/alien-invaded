//
//  PlayerHudDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 24/03/22.
//

import Foundation
import CoreGraphics

protocol PlayerHudDelegate: AnyObject {
    func updateHealth(_ percentOfMaxHealth: CGFloat)
    func updateExperience(_ percentOfMaxExperience: CGFloat)
    func updateUpgradeLabel(upgrades: [PlayerUpgrade: Float])
}
