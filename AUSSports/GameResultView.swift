//
//  GameResultView.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import SwiftUI
import AUSAPI

struct GameResultView: View {
    
    @ObservedObject var viewModel: GameResultViewModel

    init(viewModel: GameResultViewModel) {
      self.viewModel = viewModel
    }
    
    var body: some View {
      NavigationView {
        List {
          if viewModel.dataSource.isEmpty {
            emptySection
          } else {
            resultSection
          }
        }
          .listStyle(GroupedListStyle())
          .navigationBarTitle("Scores 🏀")
      }.onAppear(perform: viewModel.fetch)
    }
}

private extension GameResultView {
    var emptySection: some View {
        Text("Loading...")
    }
    var resultSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: GameResultRowView.init(viewModel:))
        }
    }
}
