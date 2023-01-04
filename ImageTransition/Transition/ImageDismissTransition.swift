//
//  ImageDismissTransition.swift
//  ImageTransition
//
//  Created by Work on 01/01/2023.
//

import UIKit

class ImageDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    struct Constant {
        static let duration = 0.5
    }
    
    var startFrame = UIScreen.main.bounds
    var endFrame: CGRect
    let imageView: UIImageView
    
    init(imageView: UIImageView) {
//        self.startFrame = startFrame
        self.imageView = imageView
        endFrame = imageView.frame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)-> TimeInterval {
        return Constant.duration
    }
    
    private func setupScaleTransform() -> CGAffineTransform {
        let xScaleFactor = endFrame.width / startFrame.width
        let yScaleFactor = endFrame.height / startFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        return scaleTransform
    }
    
    private func setupDestinationView(transitionContext: UIViewControllerContextTransitioning) -> UIView {
        guard let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
              let destinationView = destinationViewController.view else {
            return UIView()
        }
        return destinationView
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let currentView = setupDestinationView(transitionContext: transitionContext)
        UIView.animate(withDuration: Constant.duration, animations: {
            currentView.transform = self.setupScaleTransform()
            currentView.center = CGPoint(x: self.endFrame.midX,y: self.endFrame.midY)
        }, completion:{_ in
            self.imageView.isHidden = false
            transitionContext.completeTransition(true)
        })
    }
}
