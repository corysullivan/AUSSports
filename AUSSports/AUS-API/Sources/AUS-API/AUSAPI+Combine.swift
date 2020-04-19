//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-04-11.
//

import Combine
import Foundation

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

    public func fetchNews(for sport: Sport) -> AnyPublisher<[News], AUSNetworkError> {
        Deferred {
            Future<[News], AUSNetworkError> { promise in
                self.fetchNews(for: sport) { result in
                    switch result {
                    case .success(let news):
                        return promise(.success(news))
                    case .failure(let error):
                        return promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
