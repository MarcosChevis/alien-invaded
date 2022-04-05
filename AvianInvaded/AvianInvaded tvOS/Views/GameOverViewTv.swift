//
//  GameOverViewTv.swift
//  AvianInvaded tvOS
//
//  Created by Marcos Chevis on 05/04/22.
//

import Foundation
import UIKit

class GameOverViewTv: GameOverView {
    
    override init(score: Int) {
        super.init(score: score)
        
        mainMenuButton.layer.opacity = 0.7
        mainMenuButton.layer.borderWidth = 0
        mainMenuButton.titleLabel?.font = .munro(size: 56)
        
        restartButton.titleLabel?.font = .munro(size: 56)
          
        scoreLabel.font = .munro(size: 100)
        titleLabel.font = .munro(size: 120)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
