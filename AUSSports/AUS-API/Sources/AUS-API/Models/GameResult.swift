import Foundation

public struct GameResult {
    public let date: Date
    public let homeTeam: Team
    public let awayTeam: Team
    public let homeScore: Int?
    public let awayScore: Int?
    public let status: GameStatus
}

public enum GameStatus {
    case pending
    case live
    case final
}

public extension GameResult {
    init(withScore: Bool) {
        awayTeam = Team.acadia
        awayScore = withScore ? 10 : nil
        homeTeam = Team.stfx
        homeScore = withScore ? 20 : nil
        date = Date()
        status = .final
    }
}
