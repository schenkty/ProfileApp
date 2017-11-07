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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: URL(string: url)!))
    }

    @IBAction func closeWeb(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
