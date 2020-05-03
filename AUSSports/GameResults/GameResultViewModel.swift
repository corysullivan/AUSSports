//
//  GameResultViewModel.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import AUS_API
import Combine
import Foundation

class GameResultViewModel: ObservableObject, Identifiable {
    private var api: AUSAPI
    private var disposables = Set<AnyCancellable>()

    @Published var dataSource: [GameResultRowViewModel] = []

    init(api: AUSAPI = AUSAPI.shared) {
        self.api = api
    }

    func viewDidAppear() {
        fetch()
    }

    func fetch() {
        api.fetchSchedule(with: .schedule(for: .basketballMens))
            // .map { $0.filter { $0.homeTeam == .stfx } }
            .map { $0.map(GameResultRowViewModel.init) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case let .failure(error):
                    self.dataSource = []
                    print(error)
                }
            }) { result in
                self.dataSource = result
            }.store(in: &disposables)
    }
}
