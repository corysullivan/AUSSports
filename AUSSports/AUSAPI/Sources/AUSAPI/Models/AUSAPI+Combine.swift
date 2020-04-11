//
//  File.swift
//  
//
//  Created by Cory Sullivan on 2020-04-11.
//

import Foundation
import Combine

extension AUSAPI {
    public func fetchSchedule(with options: ScheduleOptions = .stfx) -> AnyPublisher<[GameResult], Error> {
        Deferred {
            Future<[GameResult], Error> { promise in
                self.fetchSchedule(with: options) { result in
                    switch result {
                    case .success(let gameResults):
                        return promise(.success(gameResults))
                    case .failure(let error):
                        return promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
