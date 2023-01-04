//
//  ImageTransitionManager.swift
//  ImageTransition
//
//  Created by Work on 01/01/2023.
//

import UIKit

struct ImageTransitionManager {
    
    let imageView: UIImageView
    lazy var presentTransition = ImagePresentTransition(imageView: imageView)
    lazy var dismissTransition = ImageDismissTransition(imageView: imageView)
}
