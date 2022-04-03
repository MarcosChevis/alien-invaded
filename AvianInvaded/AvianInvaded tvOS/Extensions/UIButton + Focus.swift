//
//  UIButton + Focus.swift
//  AvianInvaded tvOS
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import Foundation
import UIKit

extension UIButton {
    open override func didUpdateFocus(in context: UIFocusUpdateContext,
                                      with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedItem === self {
            focusButton()
        }
        
        if context.previouslyFocusedItem === self {
            unFocusButton()
        }
    }
    
    private func focusButton() {
        alpha = 1
        layer.borderWidth = 5
    }
    
    private func unFocusButton() {
        alpha = 0.7
        layer.borderWidth = 0
    }
}
