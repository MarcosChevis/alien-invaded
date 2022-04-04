//
//  CoordinatorProtocol.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [CoordinatorProtocol] { get }
    
    func start()
}

protocol MainMenuCoordinatorProtocol: CoordinatorProtocol {
    func startGame()
}

protocol GameCoordinatorProtocol: CoordinatorProtocol {
    func goToMainMenu()
    func gameOver(score: Int)
}

protocol GameOverCoordinatorProtocol: CoordinatorProtocol {
    func goToMainMenu()
    func restartGame()
}

protocol GameNavigationDelegate: AnyObject {
    func restartGame()
}

typealias Coordinator = MainMenuCoordinatorProtocol & GameCoordinatorProtocol & GameOverCoordinatorProtocol
