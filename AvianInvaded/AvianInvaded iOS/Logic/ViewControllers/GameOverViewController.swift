//
//  GameOverViewController.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import UIKit

class GameOverViewController: UIViewController {
    private let contentView = GameOverView()
    weak var coordinator: MainCoordinatorProtocol?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupBindings() {
        //contentView.playAction = { [weak self] in self?.startGame() }
    }
    
    private func startGame() {
        coordinator?.startGame()
    }
}
