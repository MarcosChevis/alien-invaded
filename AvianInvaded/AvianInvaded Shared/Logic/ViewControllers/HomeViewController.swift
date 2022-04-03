//
//  HomeViewController.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 31/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    private let contentView = HomeView()
    weak var coordinator: MainCoordinatorProtocol?
    private let audioService: AudioServiceProtocol
    
    init(audioService: AudioServiceProtocol = AudioService(), contentView: HomeView) {
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
        contentView.updateMusicButtonText(isActive: Settings.isMusicEnabled)
        contentView.updateSFXButtonText(isActive: Settings.isSfxEnabled)
        
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
        
        contentView.sfxAction = { [weak self] in
            self?.toogleSFX()
        }
    }
    
    private func toogleMusic() {
        Settings.isMusicEnabled.toggle()
        contentView.updateMusicButtonText(isActive: Settings.isMusicEnabled)
        reactToMusicState(Settings.isMusicEnabled)
    }
    
    private func toogleSFX() {
        Settings.isSfxEnabled.toggle()
        contentView.updateSFXButtonText(isActive: Settings.isSfxEnabled)
    }
    
    private func reactToMusicState(_ isActive: Bool) {
        if isActive {
            audioService.play(music: .main)
        } else {
            audioService.stop(music: .main)
        }
    }
    
    private func startGame() {
        audioService.stop(music: .main)
        coordinator?.startGame()
    }

}
