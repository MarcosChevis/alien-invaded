//
//  UIViews+Utilities.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
