//
//  Account.swift
//  darkIce
//
//  Created by Scott Murray on 21/6/20.
//  Copyright © 2020 Scott Murray. All rights reserved.
//

import Foundation

struct Account: Codable {
    var isActive: Bool
    var accountBalance: String
    var picture: String
    var age: Int
    var eyeColor: String
    var gender: String
    var name: Name
    var registered: String
    
    var isRecent: Bool {
        if let year = Int(registered.split(separator: " ")[3]) {
            return year > 2015
        } else {
            // if the account year isn't retrievable assume it is too old
            return false
        }
    }
}

struct Name: Codable {
    var first: String
    var last: String
}
