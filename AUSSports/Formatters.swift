//
//  Formatters.swift
//  AUSSports
//
//  Created by Cory Sullivan on 2020-04-11.
//  Copyright © 2020 Solbits. All rights reserved.
//

import Foundation

let dayFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "d"
    return formatter
}()

let monthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
}()

let shortDate: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
}()
