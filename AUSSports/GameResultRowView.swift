//
//  GameResultRow.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import SwiftUI
import AUSAPI

struct GameResultRowView: View {
    
    private let viewModel: GameResultRowViewModel
    
    init(viewModel: GameResultRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.homeTeamName)
                Spacer()
                Text(viewModel.homeScore)
            }
            HStack {
                Text(viewModel.awayTeamName)
                Spacer()
                Text(viewModel.awayScore)
            }
        }.padding(10)
    }
}

struct GameResultRow_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameResult(withScore: true)
        let viewModel = GameResultRowViewModel(game: game)
        return List {
          GameResultRowView(viewModel: viewModel)
        }
    }
}

