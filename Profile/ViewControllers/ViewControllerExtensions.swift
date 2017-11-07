//
//  ViewControllerExtensions.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum SpeechStatus {
    case ready
    case recognizing
    case unavailable
}


extension UIViewController {
    func showAlert(title: String, message: String? = nil, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension HomeViewController {
    func setUI(status: SpeechStatus) {
        switch status {
        case .ready:
            micButton.setImage(#imageLiteral(resourceName: "available"), for: .normal)
        case .recognizing:
            micButton.setImage(#imageLiteral(resourceName: "stop"), for: .normal)
        case .unavailable:
            micButton.setImage(#imageLiteral(resourceName: "unavailable"), for: .normal)
        }
    }
    
    func searchQuestions(title: String) {
        if let question = QuestionDataSource.searchQuestions(words: title) {
            micText.text = "\(question.title)"
        }
    }
}

extension HomeViewController {
    func commandAct(words: String) {
        guard let action = QuestionDataSource.searchQuestions(words: words) else { return }
        
        print(action.title)
        
        switch action.act {
        case "url":
            loadWebView(url: action.location)
        default:
            print("comamnd not found")
        }
    }
    
    func loadWebView(url: String) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "webVC") as! WebViewController
        webVC.url = url
        self.present(webVC, animated: true, completion: nil)
    }
}

// MARK: Table View Datasource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionDataSource.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
        let question = QuestionDataSource.questions[indexPath.row]
        cell.title.text = question.title
        cell.subText.text = question.subText
        cell.picView.image = question.icon
        return cell
    }
}
