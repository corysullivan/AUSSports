//
//  File.swift
//
//
//  Created by Cory Sullivan on 2020-05-03.
//

import Foundation

let shortDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d"
    return dateFormatter
}()
