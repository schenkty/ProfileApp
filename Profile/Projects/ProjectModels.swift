//
//  ProjectModels.swift
//  Profile
//
//  Created by Ty Schenk on 12/15/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import UIKit
import Lightbox

enum ProjectNames: String {
    case LotroComplete = "LotroComplete"
    case Scadata = "Scadata"
    case SimpliWeather = "SimpliWeather"
    case CNGFuel = "CNG Fuel"
    case NASApp = "NASApp"
    case ProximityReminders = "Proximity Reminders"
    case DiaryApp = "DiaryApp"
    case Sample = "Sample"
}

struct Project {
    let name: ProjectNames
    let about: String
    let icon: UIImage
    let images: [LightboxImage]
}

let projects: [ProjectNames: Project] = [
    .LotroComplete : Project(name: .LotroComplete, about: "With LotroComplete users can now glance at the latest Lord of the Rings Online news, view guides, check LOTRO server status, test out trait tree builds and read up on the trending forum threads. LotroComplete's Server Status page can be viewed here: lotrostatus.com", icon: #imageLiteral(resourceName: "lotrocomplete"), images: []),
    .SimpliWeather : Project(name: .SimpliWeather, about: "SimpliWeather is an easy to use weather app focused on providing the most important data while keeping data usage to a minimal. This app was based on the Treehouse weather app course but expanded upon to work with the CoreLocation framework. The goal of the app was to build something that displayed data from an external API.", icon: #imageLiteral(resourceName: "simpliweather"), images: []),
    .CNGFuel : Project(name: .CNGFuel, about: "The CNG Fuel iOS app provides users with locations and directions to all of the CNG Fuel, Inc stations.", icon: #imageLiteral(resourceName: "cng"), images: [LightboxImage( image: UIImage(named: "cf-1")!, text: ""), LightboxImage( image: UIImage(named: "cf-2")!, text: ""), LightboxImage( image: UIImage(named: "cf-3")!, text: "")])

]
