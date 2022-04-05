//
//  MainCoordinator.swift
//  AvianInvaded iOS
//
//  Created by Gabriel Ferreira de Carvalho on 01/04/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    weak var gameDelegate: GameNavigationDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol]
    
    init() {
        self.navigationController = .init()
        self.childCoordinators = []
    }
    
    func start() {
        let viewController = HomeViewController(contentView: HomeView())
        viewController.coordinator = self
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func startGame() {
        let sceneSize = CGSize(width: 1080, height: 810)
        let roomService = RoomService(builder: RoomBuilder(sceneSize: sceneSize),
                                      roomRepository: RoomRepository(),
                                      currentRoomDifficulty: .standard)
        let gameLogicController = GameLogicController(roomService: roomService)
        gameLogicController.coordinator = self
        gameDelegate = gameLogicController
        let viewController = GameViewController(gameLogicController: gameLogicController,
                                                sceneSize: sceneSize)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToMainMenu() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func gameOver(score: Int) {
        let gameOverViewController = GameOverViewController(score: score)
        gameOverViewController.coordinator = self
        navigationController.pushViewController(gameOverViewController, animated: true)
    }
    
    func restartGame() {
        navigationController.popToRootViewController(animated: false)
        startGame()
    }
}
