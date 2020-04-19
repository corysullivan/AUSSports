//
//  MainView.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-19.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NewsView(viewModel: NewsViewModel())
                .tabItem {
                    Image(systemName: "doc.plaintext")
                    Text("News")
                }
            GameResultView(viewModel: GameResultViewModel())
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Scores")
                }
            Text("Leagues")
                .tabItem {
                    Image(systemName: "sportscourt")
                    Text("Leagues")
                }
            Text("Favorites List")
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
    }
}
