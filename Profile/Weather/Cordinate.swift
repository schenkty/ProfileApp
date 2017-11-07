//
//  Cordinate.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation

struct Cordinate {
    let latitude: Double
    let longitude: Double
}

extension Cordinate: CustomStringConvertible {
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
