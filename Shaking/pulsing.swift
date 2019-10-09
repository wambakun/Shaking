//
//  pulsing.swift
//  Shaking
//
//  Created by DSMacbook on 04/10/19.
//  Copyright © 2019 DSMacbook. All rights reserved.
//

import Foundation
import UIKit

class Pulsing: CALayer{
    //
    var animationGroup = CAAnimationGroup()
    var initiatePulse: Float = 0
    var nextPulseAfter: TimeInterval = 0
    var animationDuration: TimeInterval = 2
    var radius: CGFloat = 200
    var numberOfPulse: Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(numberOfPulse: Float = Float.infinity, radius: CGFloat, Position: CGPoint) {
        super.init()
        
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulse = numberOfPulse
        self.position = Position
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        
        scaleAnimation.fromValue = NSNumber(value: initiatePulse)
        scaleAnimation.toValue = NSNumber(value: 1)
        scaleAnimation.duration = animationDuration
        
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        
        opacityAnimation.duration = animationDuration
        opacityAnimation.values = [0.4, 0.8, 0.0]
        opacityAnimation.keyTimes = [0, 0.2, 1]
        
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = animationDuration + nextPulseAfter
        self.animationGroup.repeatCount = numberOfPulse
        
        let defaultCurve = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [createScaleAnimation(), createOpacityAnimation()]
    }
    
}
