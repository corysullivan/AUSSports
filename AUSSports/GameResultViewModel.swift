//
//  GameResultViewModel.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation
import Combine
import AUS_API

class GameResultViewModel: ObservableObject, Identifiable {
    
    private var api: AUSAPI
    private var disposables = Set<AnyCancellable>()
    
    @Published var dataSource: [GameResultRowViewModel] = []

    init(api: AUSAPI = AUSAPI.shared) {
        self.api = api
    }
    
    func fetch() {
        api.fetchSchedule()
            //.map { $0.filter { $0.homeTeam == .stfx } }
            .map { $0.map(GameResultRowViewModel.init) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.dataSource = []
                    print(error)
                }
            }) { result in
                self.dataSource = result
        }.store(in: &disposables)
    }
}
