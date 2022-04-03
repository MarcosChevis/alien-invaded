//
//  PlayerStateDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 01/04/22.
//

import Foundation

protocol PlayerStateDelegate: AnyObject {
    func playerDidDie()
    func playerDidUpgrade()
}
