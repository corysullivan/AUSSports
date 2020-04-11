//
//  GameResultRowViewModel.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import AUSAPI
import SwiftUI

struct GameResultRowViewModel: Identifiable {
    
    var id: String {
        return homeTeamName + awayTeamName + month + day
    }
    
    var homeScore: String {
        if let score = game.homeScore {
            return String(score)
        }
        return "-"
    }
    
    var awayScore: String {
        if let score = game.awayScore {
            return String(score)
        }
        return "-"
    }
    
    var homeTeamName: String {
        return game.homeTeam.rawValue
    }
    
    var awayTeamName: String {
        return game.awayTeam.rawValue
    }
    
    var month: String {
        return monthFormatter.string(from: game.date)
    }
    
    var day: String {
        return dayFormatter.string(from: game.date)
    }
    
    private var game: GameResult
    
    init(game: GameResult) {
        self.game = game
    }
}
