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

func animateImage(image: UIImageView, animateTime: Double) {
    image.alpha = 0.0
    UIView.animateWithDuration(animateTime) {
        image.alpha = 1.0
    }
}

func animateButton(image: UIButton, animateTime: Double) {
    image.alpha = 0.0
    UIView.animateWithDuration(animateTime) {
        image.alpha = 1.0
    }
}

func animateLabel(label: UILabel, animateTime: Double) {
    label.alpha = 0.0
    UILabel.animateWithDuration(animateTime) {
        label.alpha = 1.0
    }
}

func animateLines(view: UIView, animateTime: Double) {
    view.alpha = 0.0
    UIView.animateWithDuration(animateTime) {
        view.alpha = 1.0
    }
}