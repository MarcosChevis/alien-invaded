//
//  GameOverViewController.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import UIKit

class GameOverViewController: UIViewController {
    private let contentView = GameOverView()
    weak var coordinator: GameOverCoordinatorProtocol?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        // Do any additional setup after loading the view.
    }
    
    private func setupBindings() {
        contentView.restartAction = { [weak self] in
            self?.restart()
        }
        
        contentView.mainAction = { [weak self] in
            self?.mainMenu()
        }
    }
    
    private func restart() {
        coordinator?.restartGame()
    }
    
    private func mainMenu() {
        coordinator?.goToMainMenu()
    }
}
