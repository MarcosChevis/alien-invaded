//
//  CGSize+Math.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 08/03/22.
//

import Foundation
import CoreGraphics

extension CGSize {
    
    static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        
        var size: CGSize = .zero
        
        size.width = lhs.width * rhs
        size.height = lhs.height * rhs
        
        return size
    }
    
    static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
        
        var size: CGSize = .zero
        
        size.width = lhs.width / rhs
        size.height = lhs.height / rhs
        
        return size
    }
}
