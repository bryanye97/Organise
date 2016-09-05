//
//  UIVIew Extension.swift
//  Organise
//
//  Created by Bryan Ye on 5/09/2016.
//  Copyright © 2016 Bryan Ye. All rights reserved.
//

import UIKit

extension UIView {
    
    func animateWithFlipEffect(withCompletionHandler completionHandler:(()->Void)?) {
        AnimationHelper.flipAnimation(self, completion: completionHandler)
    }
    
    func animateWithBounceEffect(withCompletionHandler completionHandler:(()->Void)?) {
        let viewAnimation = AnimationHelper.BounceEffect()
        viewAnimation(self){ _ in
            completionHandler?()
        }
    }
    
    func animateWithFadeEffect(withCompletionHandler completionHandler:(()->Void)?) {
        let viewAnimation = AnimationHelper.FadeOutEffect()
        viewAnimation(self) { _ in
            completionHandler?()
        }
    }
}
