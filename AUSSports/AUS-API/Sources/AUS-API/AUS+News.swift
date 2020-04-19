//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-04-19.
//

import FeedKit
import Foundation

extension AUSAPI {
    public func fetchNews(for sport: Sport, completion: @escaping (Result<[News], AUSNetworkError>) -> Void) {
        guard let feedURL = sport.newsFeed else {
            completion(.failure(.invalidURL))
            return
        }

        let parser = FeedParser(URL: feedURL)
        parser.parseAsync(queue: queue) { result in
            // map ParsingError to Error, lose type info
            let completionResult = result.mapError { parsingError -> Error in
                parsingError
            }

            switch completionResult {
            case .success(let feed):
                guard let newsItems = feed.rssFeed?.items else {
                    completion(.success([]))
                    return
                }
                let news = newsItems.compactMap(self.newsItem)
                completion(.success(news))
            case .failure(let error):
                completion(.failure(.parsingError(underlyingError: error)))
            }
        }
    }

    private func newsItem(for feedItem: RSSFeedItem) -> News? {
        guard let title = feedItem.title else { return nil }
        guard let descrption = feedItem.description else { return nil }
        guard let date = feedItem.pubDate else { return nil }
        guard let link = feedItem.link else { return nil }
        guard let linkUrl = URL(string: link) else { return nil }

        var imageUrl: URL?
        if let imageLink = feedItem.enclosure?.attributes?.url {
            imageUrl = URL(string: imageLink)
        }

        return News(title: title,
                    description: descrption,
                    date: date,
                    link: linkUrl,
                    image: imageUrl)
    }
}

public struct News {
    public let title: String
    public let description: String
    public let date: Date
    public let link: URL
    public let image: URL?
}
