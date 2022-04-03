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
    
    lazy var title: UILabel = UIComponents.menuLabel(withContent: "Avian Invasion")
    lazy var playButton: UIButton = UIComponents.menuButton(withTitle: "Play")
    lazy var musicButton: UIButton = UIComponents.menuButton(withTitle: "Music")
    lazy var sfxButton: UIButton = UIComponents.menuButton(withTitle: "SFX")
    lazy var buttonsStackView: UIStackView = UIComponents.verticalStack(arrangedSubviews:
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
    
    func updateMusicButtonText(isActive: Bool) {
        updateButtonText(musicButton, title: "Music", isActive: isActive)
    }
    
    func updateSFXButtonText(isActive: Bool) {
        updateButtonText(sfxButton, title: "SFX", isActive: isActive)
    }
    
    private func updateButtonText(_ button: UIButton,
                                  title: String,
                                  isActive: Bool) {
        let localizedTitle = NSLocalizedString(title, comment: "")
        let state = isActive ? "On" : "Off"
        let localizedState = NSLocalizedString(state, comment: "")
        
        button.setTitle(localizedTitle + ": " + localizedState, for: .normal)
    }
    
    private func setupHierarchy() {
        addSubview(title)
        addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        let titleConstraints: [NSLayoutConstraint] = [
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            title.bottomAnchor.constraint(equalTo: centerYAnchor)
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
            else {
                return
            }
            action()
        }
        playButton.addAction(playUIAction, for: .primaryActionTriggered)
        
        let musicUIAction = UIAction { [weak self] _ in
            guard
                let self = self,
                let action = self.musicAction
            else {
                return
            }
            action()
        }
        musicButton.addAction(musicUIAction, for: .primaryActionTriggered)
        
        let sfxUIAction = UIAction { [weak self] _ in
            guard
                let self = self,
                let action = self.sfxAction
            else {
                return
            }
            action()
        }
        sfxButton.addAction(sfxUIAction, for: .primaryActionTriggered)
    }
}
