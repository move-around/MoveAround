//
//  PlaceSwipeableView.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

protocol PlaceSwipeableViewDelegate {
    func swiped()
}

class PlaceSwipeableView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    let panXLimit:CGFloat = 50
    let offScreenX: CGFloat = 800
    let rotationAngle:CGFloat = 10
    
    var originalViewCenter: CGPoint!
    var delegate: PlaceSwipeableViewDelegate!
    
    
    var image: UIImage? {
        get { return placeImageView.image }
        set { placeImageView.image = newValue }
    }
    
    var name: String? {
        get {return nameLabel.text}
        set {nameLabel.text = newValue }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        // Make the view stretch with the containing view
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]

    }
    
    @IBAction func onPlaceSwiped(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)

        switch sender.state {
        case .began:
            originalViewCenter = contentView.center
        case.changed:
            let location = sender.location(in: self)
            var angle: CGFloat
            if location.y <= originalViewCenter.y {
                angle = translation.x / rotationAngle
            } else {
                angle = -translation.x / rotationAngle
            }
            contentView.transform = CGAffineTransform(rotationAngle: angle.degreesToRadians)
            contentView.center = CGPoint(x: originalViewCenter.x + translation.x, y: originalViewCenter.y)
            break
        case.ended:
            var newCenter: CGPoint = originalViewCenter
            if translation.x > panXLimit { // Move off to right
                newCenter.x = offScreenX
                delegate.swiped()
                self.removeFromSuperview()
            } else if translation.x < -panXLimit { // Move off to left
                newCenter.x = -offScreenX
                delegate.swiped()
                self.removeFromSuperview()
            } else {
                contentView.transform = CGAffineTransform.identity
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.contentView.center = newCenter
            })
        default:
            break
        }
    }
    
    /*
     
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
