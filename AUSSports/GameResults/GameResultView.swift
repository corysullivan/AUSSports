//
//  GameResultView.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import AUS_API
import Foundation
import SwiftUI

struct GameResultView: View {
    @ObservedObject var viewModel: GameResultViewModel
    @State private var favorite = 0

    init(viewModel: GameResultViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Picker(selection: $favorite, label: Text("This is favorite")) {
                Text("Red").tag(0)
                Text("Green").tag(1)
                Text("Yellow").tag(2)
            }.pickerStyle(SegmentedPickerStyle())
            if favorite == 2 {
                NavigationView {
                    List {
                        if viewModel.dataSource.isEmpty {
                            emptySection
                        } else {
                            resultSection
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Today")
                }
            } else {
                Spacer()
            }
        }.onAppear(perform: viewModel.viewDidAppear)
    }
}

private extension GameResultView {
    var emptySection: some View {
        ActivityIndicator()
            .frame(width: 50, height: 50)
    }

    var resultSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: GameResultRowView.init(viewModel:))
        }
    }
}

struct ActivityIndicator: View {
    @State private var isAnimating: Bool = false

    var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            ForEach(0 ..< 5) { index in
                Group {
                    Circle()
                        .frame(width: geometry.size.width / 5, height: geometry.size.height / 5)
                        .scaleEffect(!self.isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
                        .offset(y: geometry.size.width / 10 - geometry.size.height / 2)
                }.frame(width: geometry.size.width, height: geometry.size.height)
                    .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
                    .animation(Animation
                        .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                        .repeatForever(autoreverses: false))
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            self.isAnimating = true
        }
    }
}
