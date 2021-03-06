//
//  EnemyLogicController.swift
//  AvianInvaded
//
//  Created by thais on 11/03/22.
//

import Foundation
import Combine
import CoreGraphics
import SpriteKit

class ChickenLogicController {
    var data: EnemyData
    weak var delegate: EnemyLogicDelegate?
    
    var timeLastShot: TimeInterval
    
    var mass: CGFloat { data.mass }
    
    var playerPosition: CGPoint = .zero
    private let notificationCenter: NotificationCenter
    private var cancellables: Set<AnyCancellable>
    
    var scale: CGFloat { data.scale }
    
    init(data: EnemyData, notificationCenter: NotificationCenter = .default) {
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
            .assign(to: \.playerPosition, on: self)
            .store(in: &cancellables)
    }
    
    private func getPlayerPosition(from notification: Notification) -> CGPoint? {
        guard let position = notification.object as? CGPoint else {
            return nil
        }
        return position
    }
    
    func decideAtack(currentTime: TimeInterval, position: CGPoint) -> CGVector? {
        if (CGVector(self.playerPosition) - CGVector(position)).magnitude < data.attackDistance {
            return attack(currentTime)
        } else {
            return nil
        }
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
        
        if timePast < data.shootCadence {
            return nil
        }
        
        timeLastShot = currentTime
        let angle: CGFloat = data.facingAngle - CGFloat.pi/2
        let shootingMag: CGFloat = data.shootingMagnitude
        let shootingForce = CGVector(angle: angle, magnitude: shootingMag)
        
        return shootingForce
    }
    
    func receiveDamage(_ amount: CGFloat) -> Bool {
        data.currentHealth -= amount
        
        if data.currentHealth <= 0 {
            return true
        } else {
            return false
        }
    }
    
    func followPoint(initialPoint: CGPoint) {
    
        let r: CGFloat = data.distanceEnemyFromPlayer
        
        let playerVector = CGVector(playerPosition)
        
        let initialVector = CGVector(initialPoint)
        
        let angle = ((playerVector - initialVector).radAngle - CGFloat.pi)
        let nAngle = angle - CGFloat.pi/2
        
        data.facingAngle = nAngle
        delegate?.rotate(to: nAngle )
        
        let px = playerVector.dx + r * cos(angle)
        let py = playerVector.dy + r * sin(angle)

        let finalVector = CGVector(dx: px, dy: py)
        
        let forceVector: CGVector = (finalVector - initialVector).normalized
        
        if abs(initialVector.magnitude - finalVector.magnitude) > 10 {
            delegate?.apply(force: forceVector * 7, calculateForce: move)
        }
    }
}
