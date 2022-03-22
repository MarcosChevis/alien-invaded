//
//  Room+Utils.swift
//  AvianInvaded
//
//  Created by Gabriel Ferreira de Carvalho on 22/03/22.
//

import Foundation
import CoreGraphics

extension Room {
    var availableSpaces: [CGPoint] {
        self
            .colision
            .enumerated()
            .flatMap { y, row in
                row
                    .enumerated()
                    .compactMap { x, value in
                        if value == 1 {
                            return nil
                        }
                        return CGPoint(x: x, y: y)
                    }
            }
    }
}
