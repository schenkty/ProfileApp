//
//  CurrentWeather.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation

struct CurrentWeather {
    let temperature: Double
}

extension CurrentWeather {
    struct Key {
        static let temperature = "temperature"
    }
    
    init?(json: [String : AnyObject]) {
        guard let tempValue = json[Key.temperature] as? Double else { return nil }
        self.temperature = tempValue
    }
}
