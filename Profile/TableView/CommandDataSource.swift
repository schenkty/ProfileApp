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
    let tint: String
}

class CommandDataSource {
    static var commands: [Command] = {
        return [
            Command(title: "Show Portfolio", subText: "'Portfolio'", icon: #imageLiteral(resourceName: "safari"), tint: "blank"),
            Command(title: "Show Github", subText: "'Github'", icon: #imageLiteral(resourceName: "github"), tint: "blank"),
            Command(title: "Show Projects", subText: "'Projects'", icon: #imageLiteral(resourceName: "ic_menu_white"), tint: "black"),
            Command(title: "Show Certificate", subText: "'Certificate'", icon: #imageLiteral(resourceName: "treehouse"), tint: "blank"),
            Command(title: "Show Treehouse", subText: "'Treehouse'", icon: #imageLiteral(resourceName: "treehouse"), tint: "blank"),
            Command(title: "Show LinkedIn", subText: "'LinkedIn'", icon: #imageLiteral(resourceName: "safari"), tint: "blank"),
            Command(title: "Show Twitter", subText: "'Twitter'", icon: #imageLiteral(resourceName: "twitter"), tint: "blank"),
            Command(title: "Update Weather", subText: "'Weather'", icon: #imageLiteral(resourceName: "weather"), tint: "blank")
        ]
    }()
    
    static func searchCommands(words: String) -> Command? {
        return commands.filter{ words.contains($0.title) }.first
    }
}
