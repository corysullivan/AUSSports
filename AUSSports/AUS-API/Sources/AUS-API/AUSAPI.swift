import Foundation
import SwiftSoup

struct Constants {
    static let date = "e_date"
    static let teamName = "e_teamname"
    static let awayTeam = "e_awayteam"
    static let awayResult = "e_awayresult"
    static let homeTeam = "e_hometeam"
    static let homeResult = "e_homeresult"
}

public class AUSAPI {
    let queue = DispatchQueue(label: "com.solbits.queue", attributes: .concurrent)

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()

    public static let shared = AUSAPI()

    public func fetchSchedule(with _: ScheduleOptions = .stfx, completion: @escaping (Result<[GameResult], Error>) -> Void) {
        guard let url = URL(string: "https://www.atlanticuniversitysport.com/sports/mbkb/2019-20/schedule?confonly=1") else { return }
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

    private var lastDate: Date = Date()
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

        if let date = dateFormatter.date(from: String(dateText)) {
            lastDate = date
        }

        let awayResultText = try element.getElementsByClass(Constants.awayResult).text()
        let awayResult = Int(awayResultText)

        let homeResultText = try element.getElementsByClass(Constants.homeResult).text()
        let homeResult = Int(homeResultText)

        return GameResult(
            date: lastDate,
            homeTeam: homeTeam,
            awayTeam: awayTeam,
            homeScore: homeResult,
            awayScore: awayResult,
            status: .final
        )
    }
}

public enum AUSNetworkError: Error {
    case invalidContent
    case invalidURL
    case parsingError(underlyingError: Error)
}

public struct ScheduleOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let stfx = ScheduleOptions(rawValue: 1 << 0)
}
