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
        self.awayTeam = Team.acadia
        self.awayScore = withScore ? 10 : nil
        self.homeTeam = Team.stfx
        self.homeScore = withScore ? 20 : nil
        self.date = Date()
        self.status = .final
    }
}
