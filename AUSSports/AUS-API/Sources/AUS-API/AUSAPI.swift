import Foundation
import SwiftSoup

struct Constants {
    static let date = "e_date"
    static let teamName = "e_teamname"
    static let awayTeam = "e_awayteam"
    static let awayResult = "e_awayresult"
    static let homeTeam = "e_hometeam"
    static let homeResult = "e_homeresult"
    static let links = "e_links"
}

public class AUSAPI {
    // MARK: - Private

    private var lastDate: Date = Date()

    // MARK: Internal

    let queue = DispatchQueue(label: "com.solbits.queue", attributes: .concurrent)

    // MARK: Public

    public static let shared = AUSAPI()

    public func fetchSchedule(for endpoint: Endpoint, completion: @escaping (Result<[GameResult], Error>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(AUSNetworkError.invalidURL))
            return
        }
        queue.async {
            do {
                let document = try self.getDocument(for: url)
                let results = try self.loadGameResults(from: document)
                completion(.success(results))
                return
            } catch {
                completion(.failure(error))
            }
        }
    }
}

private extension AUSAPI {
    private func getDocument(for url: URL) throws -> Document {
        let data = try Data(contentsOf: url)
        guard let content = String(data: data, encoding: .ascii) else { throw AUSNetworkError.invalidContent }
        return try SwiftSoup.parse(content)
    }

    private func loadGameResults(from document: Document) throws -> [GameResult] {
        let results = try document.select("tr").filter { element in
            if element.hasClass("odd") || element.hasClass("even") {
                return try element.getElementsByIndexEquals(0).hasClass(Constants.date)
            } else {
                return false
            }
        }

        return try results.compactMap(toResult)
    }

    private func toResult(_ element: Element) throws -> GameResult? {
        guard let awayTeamName = try element.getElementsByClass(Constants.awayTeam).first()?.getElementsByClass(Constants.teamName).text() else {
            print("no away team for element \(element)")
            return nil
        }
        guard let awayTeam = Team(rawValue: awayTeamName) else { return nil }

        guard let homeTeamName = try element.getElementsByClass(Constants.homeTeam).first()?.getElementsByClass(Constants.teamName).text() else {
            print("no home team for element \(element)")
            return nil
        }
        guard let homeTeam = Team(rawValue: homeTeamName) else { return nil }

        let dateText = try element.getElementsByClass(Constants.date).text().dropFirst(4)

        if let date = shortDateFormatter.date(from: String(dateText)) {
            lastDate = date
        }

        let awayResultText = try element.getElementsByClass(Constants.awayResult).text()
        let awayResult = Int(awayResultText)

        let homeResultText = try element.getElementsByClass(Constants.homeResult).text()
        let homeResult = Int(homeResultText)

        let linkElements = try element.getElementsByClass(Constants.links)
        let gameLinks = links(for: linkElements)

        return GameResult(
            date: lastDate,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            homeScore: homeResult,
            awayScore: awayResult,
            status: .final,
            links: gameLinks
        )
    }

    /// Parse links for a specifc game
    private func links(for elements: Elements) -> [GameLink] {
        guard let links = try? elements.select("a") else { return [] }

        return links.compactMap { element -> GameLink? in
            guard let linkHref = try? element.attr("href") else { return nil }
            guard let linkText = try? element.text() else { return nil }
            guard let linkType = LinkType(rawValue: linkText) else { return nil }
            return GameLink.boxScore(URL(string: "www.apple.com")!)
//            switch linkType {
//            case .boxScore:
//                return GameLink.boxScore(endPoint.append(path: linkHref))
//            case .video:
//                return GameLink.video(endPoint.append(path: linkHref))
//            case .recap:
//                return GameLink.recap(endPoint.append(path: linkHref))
//            }
        }
    }
}

public enum AUSNetworkError: Error {
    case invalidContent
    case invalidURL
    case parsingError(underlyingError: Error)
}

private enum LinkType: String {
    case boxScore = "Box Score"
    case video = "Video"
    case recap = "Recap"
}
