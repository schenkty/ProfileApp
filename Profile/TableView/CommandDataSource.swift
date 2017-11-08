//
//  CommandDataSource.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import UIKit

enum CommandAct {
    case Url
    case View
}

struct Command {
    let title: String
    let subText: String
    let icon: UIImage
}

class CommandDataSource {

    static var commands: [Command] = {
        return [
            Command(title: "Show Portfolio", subText: "'Portfolio'", icon: #imageLiteral(resourceName: "safari")),
            Command(title: "Show Github", subText: "'Projects'", icon: #imageLiteral(resourceName: "github")),
            Command(title: "Show Treehouse", subText: "'Treehouse'", icon: #imageLiteral(resourceName: "treehouse")),
            Command(title: "Show LinkedIn", subText: "'LinkedIn'", icon: #imageLiteral(resourceName: "safari")),
            Command(title: "Show Twitter", subText: "'Twitter'", icon: #imageLiteral(resourceName: "safari"))
        ]
    }()
    
    static func searchCommands(words: String) -> Command? {
        return commands.filter{ words.contains($0.title) }.first
    }
}
