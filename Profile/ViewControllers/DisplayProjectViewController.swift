//
//  DisplayProjectViewController.swift
//  Profile
//
//  Created by Ty Schenk on 12/15/17.
//  Copyright © 2017 Ty Schenk. All rights reserved.
//

import UIKit
import Lightbox

class DisplayProjectViewController: UIViewController, LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {

    @IBOutlet var projectTextView: UITextView!
    @IBOutlet var projectImage: UIImageView!
    @IBOutlet var projectLabel: UILabel!
    
    var projectName: ProjectNames = .Sample
    var project: Project = Project(name: .Sample, about: "This is sample Text", icon: #imageLiteral(resourceName: "treehouse"), images: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let currentProject = projects[projectName] else {  showAlert(title: "Can't Find Project"); return }
        project = currentProject
        projectTextView.text = currentProject.about
        projectImage.image = currentProject.icon
        projectLabel.text = currentProject.name.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showImages(_ sender: UIButton) {
        if project.images.count != 0 {
            let controller = LightboxController(images: project.images)
            
            // Set delegates.
            controller.pageDelegate = self
            controller.dismissalDelegate = self
            controller.configureLayout(CGSize(width: 100, height: 178))
            
            // Use dynamic background.
            controller.dynamicBackground = true
            
            // Present your controller.
            present(controller, animated: true, completion: nil)
        } else {
            showAlert(title: "No Images Availble")
            return
        }
    }
    
    // Lightbox Delegates
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
