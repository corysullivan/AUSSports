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
    @State private var favorite = 0
    
    init(viewModel: GameResultViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        TabView {
            Text("The First Tab")
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
            }
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
            }.tabItem {
                Image(systemName: "2.square.fill")
                Text("Scores")
            }.onAppear(perform: viewModel.fetch)
            Text("The Last Tab")
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
            }
        }
        .font(.headline)
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
      ForEach(0..<5) { index in
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