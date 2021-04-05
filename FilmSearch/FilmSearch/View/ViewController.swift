//
//  ViewController.swift
//  FilmSearch
//
//  Created by Antonio González Valdepeñas.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBlur()
        startButton.layer.cornerRadius = 10
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Set background blur effect
    func setBlur(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageBackground.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.96
        imageBackground.addSubview(blurEffectView)
        imageBackground.bringSubviewToFront(blurEffectView)
    }

    //MARK: - @IBActions
    @IBAction func startTapped(_ sender: Any) {
        performSegue(withIdentifier: "showTabBar", sender: self)
    }
    
}

