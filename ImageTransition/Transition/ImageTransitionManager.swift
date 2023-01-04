//
//  ImageTransitionManager.swift
//  ImageTransition
//
//  Created by Work on 01/01/2023.
//

import UIKit

struct ImageTransitionManager {
    
    let imageView: UIImageView
    var presentTransition: ImagePresentTransition
    var dismissTransition: ImageDismissTransition
    
    init(imageView: UIImageView) {
        self.imageView = imageView
        self.presentTransition = ImagePresentTransition(imageView: imageView)
        self.dismissTransition = ImageDismissTransition(imageView: imageView)
    }
}
