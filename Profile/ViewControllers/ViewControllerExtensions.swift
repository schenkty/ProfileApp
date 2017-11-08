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
            micButton.setBackgroundImage(#imageLiteral(resourceName: "available"), for: .normal)
        case .recognizing:
            micButton.setBackgroundImage(#imageLiteral(resourceName: "stop"), for: .normal)
        case .unavailable:
            micButton.setBackgroundImage(#imageLiteral(resourceName: "unavailable"), for: .normal)
        }
    }
}

extension HomeViewController {    
    func loadWebView(url: String) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "webVC") as! WebViewController
        webVC.url = url
        self.present(webVC, animated: true, completion: nil)
    }
    
    func launchCommand(text: String) {
        switch text {
        case "Treehouse":
            self.loadWebView(url: "https://teamtreehouse.com/tyschenk")
        case "LinkedIn":
            self.loadWebView(url: "https://www.linkedin.com/in/schenkty/")
        case "Projects":
            // MARK: Load card screen instead of github
            self.loadWebView(url: "https://github.com/schenkty")
        case "Twitter":
            self.loadWebView(url: "https://twitter.com/schenkty")
        case "Portfolio":
            self.loadWebView(url: "https://tyschenk.com")
        case "Weather":
            self.updateWeather()
        default:
            print("No command")
        }
    }
}

// MARK: Table View Datasource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommandDataSource.commands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommandCell", for: indexPath) as! CommandCell
        let command = CommandDataSource.commands[indexPath.row]
        cell.title.text = command.title
        cell.subText.text = command.subText
        cell.picView.image = command.icon
        return cell
    }
}
