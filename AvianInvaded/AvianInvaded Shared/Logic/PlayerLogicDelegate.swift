//
//  PlayerLogicDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 07/03/22.
//

import Foundation
import CoreGraphics

protocol PlayerLogicDelegate: AnyObject {
    func move(to: CGPoint)
}
