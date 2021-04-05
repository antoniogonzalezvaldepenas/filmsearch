//
//  ContactViewController.swift
//  FilmSearch
//
//  Created by Antonio González Valdepeñas.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var linkedinButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        linkedinButton.layer.cornerRadius = 10
        emailButton.layer.cornerRadius = 10
        
        linkedinButton.imageView?.contentMode = .scaleAspectFit
        linkedinButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        emailButton.imageView?.contentMode = .scaleAspectFit
        emailButton.imageEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Contact me"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.topItem?.title = "Contact me"
    }
    
    @IBAction func linkedinTapped(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/in/antoniogonzalezvaldepenas/") {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func emailTapped(_ sender: Any) {
        if let url = URL(string: "mailto:antoniogonzalezvaldepenas@gmail.com") {
            UIApplication.shared.open(url)
        }
    }
    
}
