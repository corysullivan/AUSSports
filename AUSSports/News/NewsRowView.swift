//
//  File.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-19.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import SwiftUI

struct NewsRowView: View {
    private let viewModel: NewsRowViewModel

    init(viewModel: NewsRowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Text(viewModel.title)
    }
}
