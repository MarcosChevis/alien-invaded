//
//  LifeCycleElement.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 08/03/22.
//

import Foundation

protocol LifeCycleElement {
    func startup()
    func update(_ currentTime: TimeInterval)
    func tearDown()
    func didSimulatePhysics()
}

extension LifeCycleElement {
    func startup() {}
    func update(_ currentTime: TimeInterval) {}
    func tearDown() {}
    func didSimulatePhysics() {}
}
