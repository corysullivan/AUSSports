//
//  GameResultRow.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import AUS_API
import Foundation
import SwiftUI

struct GameResultRowView: View {
    private let viewModel: GameResultRowViewModel

    init(viewModel: GameResultRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationLink(destination: BoxScoreView(viewModel: viewModel)) {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(viewModel.month) \(viewModel.day)").font(.caption)
                HStack {
                    Image(viewModel.homeLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20, alignment: .center)
                    Text(viewModel.homeTeamName).font(.headline)
                    Spacer()
                    Text(viewModel.homeScore).font(.body)
                }
                HStack {
                    Image(viewModel.awayLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 20, height: 20, alignment: .center)
                    Text(viewModel.awayTeamName).font(.headline)
                    Spacer()
                    Text(viewModel.awayScore).font(.body)
                }
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

struct BoxScoreView: View {
    private let viewModel: GameResultRowViewModel

    init(viewModel: GameResultRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(viewModel.awayTeamName)
    }
}
