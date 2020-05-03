//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-05-03.
//

import Foundation

public struct Config: Decodable {
    public let topNews: URL
    public let schools: [School]
    public let sports: [Sport]
}
