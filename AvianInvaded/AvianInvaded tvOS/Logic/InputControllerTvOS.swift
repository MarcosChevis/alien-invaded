//
//  GameScenetvOS.swift
//  AvianInvaded tvOS
//
//  Created by Marcos Chevis on 15/03/22.

import Foundation
import GameController

class InputControllerTvOS: InputControllerProtocol {
    
    weak var delegate: InputDelegate?
    
    private var gamePadRight: GCControllerDirectionPad?
    private var gamePadLeft: GCControllerDirectionPad?
    
    var preferedInput: InputType
    
    init(preferedInput: InputType = .controller) {
        self.preferedInput = preferedInput
        self.observeForGameControllers()
    }
    
    func update(_ currentTime: TimeInterval) {
        
        guard let gamePadLeft = gamePadLeft, let gamePadRight = gamePadRight else {
            return
        }
        let rightJoystickData = getJoystickData(joystick: gamePadRight)
        let leftJoystickData = getJoystickData(joystick: gamePadLeft)
        
        if rightJoystickData.intensity != 0 {
            delegate?.updateBodyAngle(direction: rightJoystickData.direction)
            delegate?.shoot(currentTime)
//            haptic?.supportedLocalities
            
        }
        
        if leftJoystickData.intensity != 0 {
            delegate?.updateLegsAngle(direction: leftJoystickData.direction)
            delegate?.updateMovement(vector: CGVector(dx: gamePadLeft.xAxis.value,
                                                      dy: gamePadLeft.yAxis.value))
            
        }
    }
    
    private func getJoystickData(joystick: GCControllerDirectionPad) -> (direction: CGFloat,
                                                                         intensity: CGFloat) {
        
        let vector: CGVector = CGVector.init(dx: joystick.xAxis.value, dy: joystick.yAxis.value)
        let direction: CGFloat = vector.radAngle
        let intensity: CGFloat = vector.magnitude
        
        return (direction, intensity)
    }
    
    private func observeForGameControllers() {
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.handleControllerDidConnect),
            name: NSNotification.Name.GCControllerDidBecomeCurrent, object: nil)
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(self.handleControllerDidDisconnect),
            name: NSNotification.Name.GCControllerDidStopBeingCurrent, object: nil)
        
        guard let controller = GCController.controllers().first else { return }
        registerGameController(controller)
        
    }
    
    // MARK: Input Registrations
    private func registerGameController(_ gameController: GCController) {
        
        // para mudar a cor do led do controle de PS4
        // gameController.light?.color = GCColor(red: 0.5, green: 0.5, blue: 0.5)
        
        if let gamepad = gameController.extendedGamepad {
            self.gamePadLeft = gamepad.leftThumbstick
            self.gamePadRight = gamepad.rightThumbstick
        }
    }
    
    private func unregisterGameController() {
        gamePadLeft = nil
        gamePadRight = nil
    }
    
    // MARK: Connection Handlers
    @objc
    private func handleControllerDidConnect(_ notification: Notification) {
        guard let gameController = notification.object as? GCController else {
            return
        }
        
        unregisterGameController()
        
        registerGameController(gameController)
        delegate?.didChangeInputType(to: .controller)
    }
    
    @objc
    private func handleControllerDidDisconnect(_ notification: Notification) {
        unregisterGameController()
        delegate?.didChangeInputType(to: .controller)
    }
}
