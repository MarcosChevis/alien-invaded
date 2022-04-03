//
//  EnemyLogicDelegate.swift
//  AvianInvaded
//
//  Created by thais on 15/03/22.
//

import Foundation
import CoreGraphics

protocol EnemyLogicDelegate: AnyObject {
    func apply(force vector: CGVector,
               calculateForce: (CGVector, CGVector) -> CGVector?) 
    func rotate(to angle: CGFloat)
}
