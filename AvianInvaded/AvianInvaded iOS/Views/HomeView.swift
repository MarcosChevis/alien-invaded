//
//  HomeView.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 31/03/22.
//

import UIKit

class HomeView: UIView {
    
    var playAction: (() -> Void)?
    var musicAction: (() -> Void)?
    var sfxAction: (() -> Void)?
    
    private lazy var title: UILabel = UIComponents.menuLabel(withContent: "Avian Invasion")
    private lazy var playButton: UIButton = UIComponents.menuButton(withTitle: "Play")
    private lazy var musicButton: UIButton = UIComponents.menuButton(withTitle: "Music")
    private lazy var sfxButton: UIButton = UIComponents.menuButton(withTitle: "SFX")
    private lazy var buttonsStackView: UIStackView = UIComponents.verticalStack(arrangedSubviews:
                                                                                    playButton,
                                                                                    musicButton,
                                                                                    sfxButton)
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
        setupActions()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(title)
        addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        let titleConstraints: [NSLayoutConstraint] = [
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50)
        ]
        
        let stackViewContraints: [NSLayoutConstraint] = [
            buttonsStackView.topAnchor.constraint(equalTo: centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate(stackViewContraints)
        
        [playButton, sfxButton, musicButton].forEach { button in
            setupButtonConstraints(for: button)
        }
    }
    
    private func setupButtonConstraints(for button: UIButton) {
        let buttonConstraints: [NSLayoutConstraint] = UIComponents.buttonConstraints(for: button,
                                                                                     view: self)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    private func setupActions() {
        let playUIAction = UIAction { [weak self] _ in
            guard
                let self = self,
                let action = self.playAction
            else { return }
            action()
        }
        playButton.addAction(playUIAction, for: .touchUpInside)
    }
    
}

extension UIFont {
    static func munro(size: CGFloat) -> UIFont? {
        UIFont(name: "munro", size: size)
    }
}
