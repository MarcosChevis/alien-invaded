//
//  HomeView.swift
//  AvianInvaded tvOS
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import Foundation
import UIKit

class HomeViewTV: HomeView {
    
    override init() {
        super.init()
        setupFocusInitialState()
    }
    
    private func setupFocusInitialState() {
        sfxButton.layer.opacity = 0.7
        musicButton.layer.opacity = 0.7
        sfxButton.layer.borderWidth = 0
        musicButton.layer.borderWidth = 0
        musicButton.titleLabel?.font = .munro(size: 56)
        sfxButton.titleLabel?.font = .munro(size: 56)
        playButton.titleLabel?.font = .munro(size: 56)
        musicButton.layer.cornerRadius = 16
        sfxButton.layer.cornerRadius = 16
        playButton.layer.cornerRadius = 16
        title.font = .munro(size: 120)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
