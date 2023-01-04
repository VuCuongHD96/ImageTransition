//
//  ViewController.swift
//  ImageTransition
//
//  Created by Work on 30/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!

    lazy var imageTransitionManager = ImageTransitionManager(imageView: myImageView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMyImageView()
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
