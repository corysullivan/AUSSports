import Combine
import Foundation

public class SolbitsAPI {
    private let configUrl = URL(string: "https://corysullivan.github.io/AUSConfig/config.json")!
    private let session = URLSession.shared

    public static let shared = SolbitsAPI()

    public func fetchConfig() -> AnyPublisher<Config, Error> {
        session.dataTaskPublisher(for: configUrl)
            .retry(1)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                guard element.data.count > 0 else { throw URLError(.zeroByteResource) }
                return element.data
            }
            .decode(type: Config.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
