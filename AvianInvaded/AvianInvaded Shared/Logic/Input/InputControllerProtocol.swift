//
//  InputControllerProtocol.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/03/22.
//

import Foundation

protocol InputControllerProtocol: AnyObject {
    
    var delegate: InputDelegate? { get set }
    
    var preferedInput: InputType { get }
    
    func update(_ currentTime: TimeInterval)
}
