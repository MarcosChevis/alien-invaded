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
    
    private var gameCenterController: GameCenterController
    
    init() {
        self.navigationController = .init()
        self.gameCenterController = GameCenterController()
        self.childCoordinators = []
    }
    
    func start() {
        let viewController = HomeViewController()
        viewController.coordinator = self
        presentGameCenter(presenterVc: viewController)
        gameCenterController.setupActionPoint(location: .topLeading, showHighlights: false, isActive: true)
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func presentGameCenter(presenterVc: UIViewController) {
        gameCenterController.auth { result in
            switch result {
            case .success(let vc):
                presenterVc.present(vc, animated: true)
            default:
                return
            }
        }
    }
    
    func startGame() {
        let sceneSize = CGSize(width: 1080, height: 810)
        let roomService = RoomService(builder: RoomBuilder(sceneSize: sceneSize),
                                      roomRepository: RoomRepository(),
                                      currentRoomDifficulty: .standard)
        let gameLogicController = GameLogicController(roomService: roomService)
        gameCenterController.setupActionPoint(location: .topLeading, showHighlights: false, isActive: false)
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
        gameCenterController.sendScoreToLeaderboard(score: score)
        navigationController.pushViewController(gameOverViewController, animated: true)
    }
    
    func restartGame() {
        navigationController.popToRootViewController(animated: false)
        startGame()
    }
}
