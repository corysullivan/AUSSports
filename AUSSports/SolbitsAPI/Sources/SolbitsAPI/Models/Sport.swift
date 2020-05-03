//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-05-03.
//

import Foundation

public struct Sport: Decodable {
    let type: SportType
    let gender: Gender
    let feeds: SportFeeds
}

public enum SportType: String, Decodable {
    case hockey
    case basketball
}

public enum Gender: String, Decodable {
    case male
    case female
}

public struct SportFeeds: Decodable {
    let news: URL
    let schedule: URL
    let playoffs: URL?
}
