//
//  GameOverView.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import UIKit

class GameOverView: UIView {
    
    private lazy var titleLabel: UILabel = UIComponents.menuLabel(withContent: "Game Over")
    private lazy var scoreLabel: UILabel = UIComponents.menuLabel(withContent: "Score: 0", size: 32)
    private lazy var restartButton: UIButton = UIComponents.menuButton(withTitle: "Restart")
    private lazy var mainMenuButton: UIButton = UIComponents.menuButton(withTitle: "Main Menu")
    private lazy var buttonStackView: UIStackView = UIComponents.verticalStack(arrangedSubviews:
                                                                                restartButton,
                                                                                mainMenuButton)
    
    var restartAction: (() -> Void)?
    var mainAction: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubviews(titleLabel,
                    scoreLabel,
                    buttonStackView)
    }
    
    private func setupConstraints() {
        [restartButton,
         mainMenuButton].forEach {
            NSLayoutConstraint.activate(
                UIComponents.buttonConstraints(for: $0, view: self)
            )
        }
        
        let scoreLabelConstraints: [NSLayoutConstraint] = [
            scoreLabel.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -16),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.bottomAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        let stackViewConstraints: [NSLayoutConstraint] = [
            buttonStackView.topAnchor.constraint(equalTo: centerYAnchor, constant: 16),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ]
        
        let constraints = scoreLabelConstraints + titleLabelConstraints + stackViewConstraints
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupActions() {
        let restartUIAction = UIAction { [weak self] _ in
            guard
                let self = self,
                let action = self.restartAction
            else {
                return
            }
            action()
        }
        restartButton.addAction(restartUIAction, for: .primaryActionTriggered)
        
        let mainMenuUIAction = UIAction { [weak self] _ in
            guard
                let self = self,
                let action = self.mainAction
            else {
                return
            }
            action()
        }
        mainMenuButton.addAction(mainMenuUIAction, for: .primaryActionTriggered)
    }
    
}
