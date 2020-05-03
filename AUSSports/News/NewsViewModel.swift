//
//  NewsViewModel.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-19.
//  Copyright © 2020 Solbits. All rights reserved.
//

import AUS_API
import Combine
import Foundation
import SolbitsAPI

class NewsViewModel: ObservableObject, Identifiable {
    private let api: AUSAPI
    private var disposables = Set<AnyCancellable>()

    @Published var dataSource: [NewsRowViewModel] = []

    init(api: AUSAPI = AUSAPI.shared) {
        self.api = api
    }

    deinit {
        print("Deinit: NewsViewModel")
    }

    func viewDidAppear() {
        fetchNews()
    }

    // TODO: add a retry
    func fetchNews() {
        api.fetchNews(for: .all)
            .map { $0.map(NewsRowViewModel.init) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    self.dataSource = []
                    print("Could not fetch News feed \(error)")
                }
            }) { result in
                self.dataSource = result
            }.store(in: &disposables)        
    }
}
