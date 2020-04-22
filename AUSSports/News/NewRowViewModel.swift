//
//  NewRowViewModel.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-19.
//  Copyright © 2020 Solbits. All rights reserved.
//

import AUS_API
import Foundation

struct NewsRowViewModel: Identifiable {
    private let news: News

    var id: String {
        news.title
    }

    var title: String {
        news.title
    }

    var image: URL? {
        news.image
    }

    var date: String {
        shortDate.string(from: news.date)
    }

    init(news: News) {
        self.news = news
    }
}
