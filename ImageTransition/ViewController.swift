//
//  ViewController.swift
//  ImageTransition
//
//  Created by Work on 30/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let url = URL(string: "https://line.me/R/")!

    
    lazy var imageTransitionManager = ImageTransitionManager(imageView: myImageView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMyImageView()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UIApplication.shared.canOpenURL(url) {
            titleLabel.text = "My App is installed"
        } else {
            titleLabel.text = "My App is not installed"
        }
    }
    
    @IBAction func deepLinkAction(_ sender: Any) {
        UIApplication.shared.open(url)
    }
    
    @IBAction func sendMessAction(_ sender: Any) {
        let url2 = URL(string: "https://line.me/R/share?text=abc")!
        UIApplication.shared.open(url2)

    }
    
    private func setupMyImageView() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(presentImageScreen))
        myImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func presentImageScreen() {
        
        
        let imageScreen = ImageViewController()
        //        imageScreen.transitioningDelegate = self
        imageScreen.transitionImageView = myImageView
        imageScreen.modalPresentationStyle = .fullScreen//.custom
        present(imageScreen, animated: false)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //        myImageView.isHidden = true
        return imageTransitionManager.presentTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        //        myImageView.isHidden = false
        return imageTransitionManager.dismissTransition
    }
}
