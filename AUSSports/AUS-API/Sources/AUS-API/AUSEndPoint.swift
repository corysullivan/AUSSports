//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-05-03.
//

import Foundation

public struct Endpoint {
    public let path: String
    public let queryItems: [URLQueryItem]
}

extension Endpoint {
    public static func schedule(for sport: Sport, conferenceOnly: Bool = true) -> Endpoint {
        Endpoint(
            path: sport.schedulePath,
            queryItems: [
                URLQueryItem(name: "confonly", value: conferenceOnly ? "1" : "0"),
            ]
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.atlanticuniversitysport.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
