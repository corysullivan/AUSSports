//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-05-03.
//

import Foundation

public struct ScheduleOptions: OptionSet {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let stfx = ScheduleOptions(rawValue: 1 << 0)
}
