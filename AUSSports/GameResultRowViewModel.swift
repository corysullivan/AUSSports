//
//  GameResultRowViewModel.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import AUS_API
import Foundation
import SwiftUI

struct GameResultRowViewModel: Identifiable {
    var id: String {
        return homeTeamName + awayTeamName + homeScore + awayScore
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

    var homeLogo: String {
        return game.homeTeam.logoName
    }

    var awayLogo: String {
        return game.awayTeam.logoName
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

extension Team {
    var logoName: String {
        switch self {
        case .stfx:
            return "stfx_logo"
        case .saintMarys:
            return "smu_logo"
        default:
            return "logo_placeholder"
        }
    }
}
