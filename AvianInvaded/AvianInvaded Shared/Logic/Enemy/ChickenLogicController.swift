//
//  EnemyLogicController.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import Combine
import CoreGraphics

class ChickenLogicController{
    var data: EnemyData
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    
    private var life = 10
    private let notificationCenter: NotificationCenter
    private var cancellables: Set<AnyCancellable>
    
    var scale: CGFloat { data.scale }
    
    init(data: EnemyData = .init(), notificationCenter: NotificationCenter = .default) {
        self.data = data
        self.timeLastShot = 0
        self.notificationCenter = notificationCenter
        self.cancellables = .init()
        setupBindings()
    }
    
    private func setupBindings() {
        notificationCenter
            .publisher(for: .playerDidMove, object: nil)
            .compactMap(getPlayerPosition)
            .sink(receiveValue: updatePlayerPosition)
            .store(in: &cancellables)
    }
    
    private func getPlayerPosition(from notification: Notification) -> CGPoint? {
        guard let position = notification.object as? CGPoint else {
            return nil
        }
        return position
    }
    
    private func updatePlayerPosition(_ position: CGPoint) {
        #warning("Update Player Position")
    }
    
    func move(by vector: CGVector, currentVelocity: CGVector) -> CGVector? {
        if currentVelocity.magnitude < data.speedLimit {
            return vector * data.moveMultiplier
        } else {
            return nil
        }
    }
    
    func attack(_ currentTime: TimeInterval) -> CGVector? {
        
        if timeLastShot == 0 {
            timeLastShot = currentTime
        }
        
        let timePast = currentTime - timeLastShot
        
        if timePast < 0.7 {
            return nil
        }
        
        timeLastShot = currentTime
        let angle: CGFloat = data.facingAngle
        let shootingMag: CGFloat = 100
        
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        return shootingForce
    }
    
    func receiveDamage() -> Bool {
        print("chamei")
        life -= 1
        
        if life <= 0 {
            return true
        } else {
            return false
        }
    }
}

