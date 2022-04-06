//
//  GameOverVieWController.swift
//  AvianInvaded tvOS
//
//  Created by Marcos Chevis on 05/04/22.
//

import UIKit

class GameOverViewController: UIViewController {
    private let contentView: GameOverView
    weak var coordinator: GameOverCoordinatorProtocol?
    private let score: Int
    
    init(score: Int) {
        self.score = score
        self.contentView = GameOverViewTv(score: score)
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
