//
//  ImageViewController.swift
//  ImageTransition
//
//  Created by Work on 30/12/2022.
//

import UIKit
import SnapKit

class ImageViewController: UIViewController {
    
    let myImageView = UIImageView()
    var scale: CGFloat = 1
    var transitionImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToCenter()
    }
    
    deinit {
        //        print("---- debug ---- ImageViewController Die")
    }
    
    private func setupImageView() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(actionPanImageView))
        myImageView.backgroundColor = .clear
        myImageView.image = transitionImageView.image
        myImageView.frame = transitionImageView.frame
        myImageView.contentMode = transitionImageView.contentMode
        myImageView.clipsToBounds = true
        myImageView.isUserInteractionEnabled = true
        view.addSubview(myImageView)
        myImageView.addGestureRecognizer(gesture)
    }
    
    private func resizeImageCalculator() -> CGSize {
        let imageSize = myImageView.image?.size
        let imageNewWidth = UIScreen.main.bounds.width
        let imageNewHeight = imageNewWidth * imageSize!.height / imageSize!.width
        return CGSize(width: imageNewWidth, height: imageNewHeight)
    }
    
    private func moveToCenter() {
        let resizeImageCalculator = resizeImageCalculator()
        print("--- size = ", resizeImageCalculator)
        UIView.animate(withDuration: 0.5) {
            self.myImageView.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width)
                make.height.equalTo(UIScreen.main.bounds.height)
                make.left.right.equalToSuperview()
                make.center.equalTo(self.view)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func actionPanImageView(pan: UIPanGestureRecognizer) {
        switch pan.state {
        case .changed:
            let myImagePoint = myImageView.frame.origin
            print("---- debug ----- myImagePoint = ", myImagePoint)
            if myImagePoint.y > 0 {
                scale -= 0.005
            } else {
                scale += 0.005
                if scale > 1 {
                    scale = 1
                }
            }
            let translation = pan.translation(in: self.view)
            let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
            let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
            let multiTransform = CGAffineTransformConcat(scaleTransform, translationTransform)
            myImageView.transform = multiTransform
//            view.alpha = scale - 0.05
        case .ended:
            print("=== end --- center Y Image =. ", myImageView.frame)
            print("=== end --- center Y View =. ", view.center.y)
            if scale <= 0.85 {
                moveToFirstPosition()
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.myImageView.transform = .identity
                }
            }
            scale = 1
        default: break
        }
    }
    
    func moveToFirstPosition() {
        UIView.animate(withDuration: 0.5) {
            self.myImageView.transform = .identity
            self.myImageView.frame = self.transitionImageView.frame
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func closeAction() {
        moveToFirstPosition()
    }
}
