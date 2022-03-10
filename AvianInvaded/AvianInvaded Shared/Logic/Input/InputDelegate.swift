//
//  InputDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation
import CoreGraphics

protocol InputDelegate: AnyObject {
        
    func didChangeInputType(to inputType: InputType?)
    
    //angle - 0..<2*PI
    //intensity - 0...1
    func updateMovement(vector: CGVector)
    func updateShooting(direction angle: CGFloat, isShooting: Bool)
    
}
