//
//  GameCenterController.swift
//  AvianInvaded
//
//  Created by Marcos Chevis on 04/04/22.
//

import Foundation
import GameKit

class GameCenterController: NSObject {
    
    let leaderbordID = "highScore"
    
    func auth(_ completionHandler: @escaping (Result<UIViewController, Error>) -> Void) {
        GKLocalPlayer.local.authenticateHandler = { vController, error in
            if let vc = vController {
                completionHandler(.success(vc))
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
    }
    
    func setupActionPoint(location: GKAccessPoint.Location, showHighlights: Bool, isActive: Bool) {
        GKAccessPoint.shared.location = location
        GKAccessPoint.shared.showHighlights = showHighlights
        GKAccessPoint.shared.isActive = isActive

    }
    
    func sendScoreToLeaderboard(score: Int) {
        GKLeaderboard.submitScore(score,
                                  context: 0,
                                  player: GKLocalPlayer.local,
                                  leaderboardIDs: [leaderbordID]) { error in
            if error != nil {
                print("deu ruim")
            } else {
                print("não deu ruim")
            }
            
        }
        
    }
}
