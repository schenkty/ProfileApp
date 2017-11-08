//
//  WebViewController.swift
//  Profile
//
//  Created by Ty Schenk on 11/7/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url: String = "https://tyschenk.com"
    @IBOutlet var webView: WKWebView!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url)!))
        /*
         button.backgroundColor = .clear
         button.layer.cornerRadius = 5
         button.layer.borderWidth = 1
         button.layer.borderColor = UIColor.black.cgColor
        */
        closeButton.layer.cornerRadius = 10
        
    }

    @IBAction func closeWeb(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
