//
//  QuestionDataSource.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import UIKit

struct Question {
    let title: String
    let subText: String
    let act: String
    let location: String
    let icon: UIImage
}

class QuestionDataSource {
    
    static var questions: [Question] = {
        return [
            Question(title: "Show Portfolio", subText: "'Portfolio'", act: "url", location: "https://tyschenk.com", icon: #imageLiteral(resourceName: "safari")),
            Question(title: "Show Github", subText: "'Projects'", act: "url", location: "https://github.com/schenkty", icon: #imageLiteral(resourceName: "github")),
            Question(title: "Show Treehouse", subText: "'Treehouse'", act: "url", location: "https://teamtreehouse.com/tyschenk", icon: #imageLiteral(resourceName: "treehouse"))
        ]
    }()
    
    static func searchQuestions(words: String) -> Question? {
        return questions.filter { words.contains($0.title) }.first
    }
}
