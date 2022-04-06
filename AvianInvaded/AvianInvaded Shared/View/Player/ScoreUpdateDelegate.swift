//
//  ScoreUpdateDelegate.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/04/22.
//

import Foundation

protocol ScoreUpdateDelegate: AnyObject {
    func updateScoreLabel(score: Int)
}
