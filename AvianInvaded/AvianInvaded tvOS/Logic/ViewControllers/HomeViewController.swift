//
//  HomeViewController.swift
//  AvianInvaded tvOS
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    private let contentView = HomeViewTV()
    weak var coordinator: MainMenuCoordinatorProtocol?
    let audioService: AudioServiceProtocol
    
    init(audioService: AudioServiceProtocol = AudioService()) {
        self.audioService = audioService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        updateFocusIfNeeded()
        
        contentView.updateMusicButtonText(isActive: Settings.isMusicEnabled)
        
        if Settings.isMusicEnabled {
            audioService.play(music: .main)
        }
    }
    
    private func setupBindings() {
        contentView.playAction = { [weak self] in
            self?.startGame()
        }
        
        contentView.musicAction = { [weak self] in
            self?.toogleMusic()
        }
        
    }
    
    private func toogleMusic() {
        Settings.isMusicEnabled.toggle()
        contentView.updateMusicButtonText(isActive: Settings.isMusicEnabled)
        reactToMusicState(Settings.isMusicEnabled)
    }
    
    private func reactToMusicState(_ isActive: Bool) {
        if isActive {
            audioService.play(music: .main)
        } else {
            audioService.stop(music: .main)
        }
    }
    
    private func startGame() {
        coordinator?.startGame()
    }

}
