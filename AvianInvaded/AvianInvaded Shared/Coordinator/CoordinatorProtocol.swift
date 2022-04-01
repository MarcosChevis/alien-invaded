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

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func startGame()
    func endGame()
}
