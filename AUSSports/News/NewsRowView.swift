//
//  File.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-19.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import KingfisherSwiftUI
import SwiftUI

struct NewsRowView<Destination: View>: View {
    private let viewModel: NewsRowViewModel
    private let destination: (NewsRowViewModel) -> Destination

    init(viewModel: NewsRowViewModel, destination: @escaping (NewsRowViewModel) -> Destination) {
        self.viewModel = viewModel
        self.destination = destination
    }

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.title)
                        .font(.headline)
                        .frame(alignment: .leading)
                    Text(viewModel.date)
                        .font(.caption)
                        .frame(alignment: .leading)
                }
                Spacer()
            }
            KFImage(viewModel.image?.makeSecure().update())
                .placeholder {
                    // Placeholder while downloading.
                    Image(systemName: "arrow.2.circlepath.circle")

                        .font(.largeTitle)
                        .opacity(0.3)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

extension URL {
    func makeSecure() -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.scheme = "https"
        return (components?.url!)!
    }

    func update() -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        let screenWidth = UIScreen.main.bounds.width * 2
        components?.queryItems = [URLQueryItem(name: "max_width", value: screenWidth.description)]
        return components?.url
    }
}
