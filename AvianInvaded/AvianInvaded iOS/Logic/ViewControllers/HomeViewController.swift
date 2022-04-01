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
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupBindings() {
        contentView.playAction = { [weak self] in self?.startGame() }
    }
    
    private func startGame() {
        coordinator?.startGame()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
