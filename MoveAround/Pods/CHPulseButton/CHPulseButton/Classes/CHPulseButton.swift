//
//  CHPulseButton.swift
//  Pods
//
//  Created by Charles HARROCH on 25/05/2016.
//
//

import Foundation
import UIKit
import QuartzCore

@IBDesignable public class CHPulseButton: UIControl {
    
    var pulseView = UIView()
    var button = UIButton()
    var imageView = UIImageView()
    
    public var isAnimate = false
    
    lazy private var pulseAnimation : CABasicAnimation = self.initAnimation()
    
    // MARK: Inspectable properties
    
    @IBInspectable public var contentImageScale : Int = 0 {
        didSet { imageView.contentMode = UIViewContentMode(rawValue: contentImageScale)! }
    }
    
    @IBInspectable public var image: UIImage? {
        get { return imageView.image }
        set(image) { imageView.image = image }
    }
    
    @IBInspectable public var pulseMargin : CGFloat = 5.0
    
    @IBInspectable public var pulseBackgroundColor : UIColor = UIColor.lightGray {
        didSet { pulseView.backgroundColor = pulseBackgroundColor }
    }
    
    @IBInspectable public var buttonBackgroundColor : UIColor = UIColor.blue {
        didSet { button.backgroundColor = buttonBackgroundColor }
    }
    
    @IBInspectable public var titleColor : UIColor = UIColor.blue {
        didSet { button.setTitleColor(titleColor, for: []) }
    }
    
    @IBInspectable public var title : String? {
        didSet { button.setTitle(title, for: []) }
    }
    
    @IBInspectable public var pulsePercent: Float = 1.2
    @IBInspectable public var pulseAlpha: Float = 1.0 {
        didSet {
            pulseView.alpha = CGFloat(pulseAlpha)
        }
    }

    @IBInspectable public var circle : Bool = false
    
    @IBInspectable public var cornerRadius : CGFloat = 0.0 {
        didSet {
            if circle == true {
                cornerRadius = 0
            } else {
                button.layer.cornerRadius = cornerRadius - pulseMargin
                imageView.layer.cornerRadius = cornerRadius - pulseMargin
                pulseView.layer.cornerRadius = cornerRadius
            }
        }
    }
    
    // MARK: Initialization
    
    func initAnimation() -> CABasicAnimation {
        let anim  = CABasicAnimation(keyPath: "transform.scale")
        anim.duration = 1
        anim.fromValue = 1
        anim.toValue = 1 * pulsePercent
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        anim.autoreverses = true
        anim.repeatCount = FLT_MAX
        return anim
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setup()
        
        if circle {
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            pulseView.layer.cornerRadius = 0.5 * pulseView.bounds.size.width
            imageView.layer.cornerRadius = 0.5 * imageView.bounds.size.width

            button.clipsToBounds = true
            pulseView.clipsToBounds = true
            imageView.clipsToBounds = true
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        
        self.backgroundColor = UIColor.clear
        
        pulseView.frame = CGRect.init(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        addSubview(pulseView)
        
        button.frame = CGRect.init(x: pulseMargin/2, y: pulseMargin/2, width: bounds.size.width - pulseMargin, height: bounds.size.height - pulseMargin)
        addSubview(button)
        
        imageView.frame = CGRect.init(x: pulseMargin/2, y: pulseMargin/2, width: bounds.size.width - pulseMargin, height: bounds.size.height - pulseMargin)
        addSubview(imageView)
        
        for target in allTargets {
            let actionss = actions(forTarget: target, forControlEvent: UIControlEvents.touchUpInside)
            for action in actionss! {
                button.addTarget(target, action:Selector(stringLiteral: action), for: UIControlEvents.touchUpInside)
            }
        }
    }
    
    public func animate(start : Bool) {
        if start {
            self.pulseView.layer.add(pulseAnimation, forKey: nil)
        } else {
            self.pulseView.layer.removeAllAnimations()
        }
        isAnimate = start
    }
}
