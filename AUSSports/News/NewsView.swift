//
//  NewsView.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-19.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import SwiftUI

struct NewsView: View {
    @ObservedObject var viewModel: NewsViewModel

    init(viewModel: NewsViewModel) {
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
            .navigationBarTitle("News")
        }.onAppear(perform: viewModel.viewDidAppear)
    }
}

private extension NewsView {
    var emptySection: some View {
        Text("Loading...")
    }

    var resultSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: NewsRowView.init(viewModel:))
        }
    }
}
