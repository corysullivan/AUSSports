//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-04-19.
//

import Foundation

public enum Sport {
    case all
    case hockeyMens
    case hockeyWomens
    case basketballMens
    case basketballWomens
    case football
    case soccerMens
    case soccerWomens
}

extension Sport {
    var newsFeed: URL? {
        switch self {
        case .all:
            return URL(string: "https://aus.prestosports.com/landing/headlines-featured?feed=rss_2.0")
        case .hockeyMens:
            return URL(string: "https://aus.prestosports.com/sports/mice/headlines-featured?feed=rss_2.0")
        case .hockeyWomens:
            return URL(string: "https://aus.prestosports.com/sports/wice/headlines-featured?feed=rss_2.0")
        case .basketballMens:
            return URL(string: "https://aus.prestosports.com/sports/mbkb/headlines-featured?feed=rss_2.0")
        case .basketballWomens:
            return URL(string: "https://aus.prestosports.com/sports/wbkb/headlines-featured?feed=rss_2.0")
        case .football:
            return URL(string: "https://aus.prestosports.com/sports/fball/headlines-featured?feed=rss_2.0")
        case .soccerMens:
            return URL(string: "https://aus.prestosports.com/sports/msoc/headlines-featured?feed=rss_2.0")
        case .soccerWomens:
            return URL(string: "https://aus.prestosports.com/sports/wsoc/headlines-featured?feed=rss_2.0")
        }
    }
}
