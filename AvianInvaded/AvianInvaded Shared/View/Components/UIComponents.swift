//
//  UIComponents.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import UIKit

enum UIComponents {
    static func menuButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.purple.cgColor
        button.layer.borderWidth = 3
        button.layer.cornerRadius = 8
        button.setTitle(NSLocalizedString(title, comment: "Play title"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .munro(size: 32)
        return button
    }
    
    static func menuLabel(withContent text: String, size: CGFloat = 48) -> UILabel {
        let label = UILabel()
        label.font = .munro(size: size)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString(text, comment: "")
        return label
    }
    
    static func verticalStack(arrangedSubviews: UIView...) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: arrangedSubviews)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }
    
    static func buttonConstraints(for button: UIButton, view: UIView) -> [NSLayoutConstraint] {
        [
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.2)
        ]
    }
}
