//
//  GameCenterControllerDelegte.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/04/22.
//

import Foundation

protocol GameCenterControllerDelegate: AnyObject {
    func sendScoreToLeaderboard(score: Int)
}


