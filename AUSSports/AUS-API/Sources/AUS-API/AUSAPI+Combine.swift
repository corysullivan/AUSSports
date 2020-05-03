//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-04-11.
//

import Combine
import Foundation

extension AUSAPI {
    public func fetchSchedule(with endPoint: Endpoint) -> AnyPublisher<[GameResult], Error> {
        Deferred {
            Future<[GameResult], Error> { promise in
                self.fetchSchedule(for: endPoint) { result in
                    switch result {
                    case let .success(gameResults):
                        return promise(.success(gameResults))
                    case let .failure(error):
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
                    case let .success(news):
                        return promise(.success(news))
                    case let .failure(error):
                        return promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
