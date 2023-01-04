//
//  ImagePresentTransition.swift
//  ImageTransition
//
//  Created by Work on 31/12/2022.
//

import UIKit

class ImagePresentTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    var startFrame: CGRect
    let endFrame = UIScreen.main.bounds
    let imageView: UIImageView

    
    init(imageView: UIImageView) {
//        self.startFrame = startFrame
        self.imageView = imageView
        startFrame = imageView.frame
    }
    
    private func setupScaleTransform() -> CGAffineTransform {
        let xScaleFactor = startFrame.width / endFrame.width
        let yScaleFactor = startFrame.height / endFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        return scaleTransform
    }
    
    private func setupDestinationView(transitionContext: UIViewControllerContextTransitioning) -> UIView {
        guard let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
              let destinationView = destinationViewController.view else {
            return UIView()
        }
        destinationView.frame = endFrame
        destinationView.transform = setupScaleTransform()
        destinationView.center = CGPoint(x: startFrame.midX, y: startFrame.midY)
        return destinationView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?)-> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
       
        let destinationView = setupDestinationView(transitionContext: transitionContext)
        let containerView = transitionContext.containerView
        containerView.addSubview(destinationView)
    
        UIView.animate(withDuration: duration, animations: {
            destinationView.transform = CGAffineTransform(scaleX: 1, y: 1)
            destinationView.center = CGPoint(x: self.endFrame.midX, y: self.endFrame.midY)
        }, completion: { _ in
            self.imageView.isHidden = true
            transitionContext.completeTransition(true)
        })
    }
}
