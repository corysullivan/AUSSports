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
    @ObservedObject private var viewModel: NewsViewModel
    @State private var isPresenting: Bool = false
    @State private var newsLink: URL?

    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            if viewModel.dataSource.isEmpty {
                emptySection
            } else {
                resultSection
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: viewModel.viewDidAppear)
        .sheet(isPresented: $isPresenting) {
            SafariView(url: self.newsLink!)
        }
    }
}

private extension NewsView {
    var emptySection: some View {
        Text("Loading...")
    }

    var resultSection: some View {
        ForEach(viewModel.dataSource) { viewModel in
            NewsRowView(viewModel: viewModel) { viewModel in
                SafariView(url: viewModel.link)
            }.onTapGesture {
                self.newsLink = viewModel.link
                self.isPresenting = true
            }
        }
    }
}
