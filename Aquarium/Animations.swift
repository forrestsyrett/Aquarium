//
//  Animations.swift
//  Aquarium
//
//  Created by Forrest Syrett on 7/14/16.
//  Copyright © 2016 Forrest Syrett. All rights reserved.
//

import Foundation
import UIKit



// ANIMATIONS

func animateImage(_ image: UIImageView, animateTime: Double) {
    image.alpha = 0.0
    UIView.animate(withDuration: animateTime, animations: {
        image.alpha = 1.0
    }) 
}

func animateButton(_ image: UIButton, animateTime: Double) {
    image.alpha = 0.0
    UIView.animate(withDuration: animateTime, animations: {
        image.alpha = 1.0
    }) 
}

func animateLabel(_ label: UILabel, animateTime: Double) {
    label.alpha = 0.0
    UILabel.animate(withDuration: animateTime, animations: {
        label.alpha = 1.0
    }) 
}


// Use UIVIEW to animate all views in cell

func animateLines(_ view: UIView, animateTime: Double) {
    view.alpha = 0.0
    UIView.animate(withDuration: animateTime, animations: {
        view.alpha = 1.0
    }) 
}
