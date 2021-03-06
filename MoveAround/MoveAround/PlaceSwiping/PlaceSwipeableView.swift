//
//  PlaceSwipeableView.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/14/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit

protocol PlaceSwipeableViewDelegate {
    func swipedRight(place:Place)
    func swipedLeft(place:Place)
    func clickedImage()
}

class PlaceSwipeableView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var noImageView: UIImageView!
    @IBOutlet weak var yesImageView: UIImageView!
    
    let panXLimit:CGFloat = 50
    let offScreenX: CGFloat = 800
    let rotationAngle:CGFloat = 10
    
    var originalViewCenter: CGPoint!
    var delegate: PlaceSwipeableViewDelegate!
    var place: Place! {
        didSet{
            if let url = place.imageURL {
                placeImageView.setImageWith(url)
            }
            nameLabel.text = place.name
            addressLabel.text = place.address
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    @IBAction func onImageTap(_ sender: UITapGestureRecognizer) {
        delegate.clickedImage()
    }
    
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        
        // Make the view stretch with the containing view
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        // corner radius
        placeImageView.layer.cornerRadius = 5
        contentView.layer.cornerRadius = 5
        
        // border
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        
        noImageView.alpha = 0
        yesImageView.alpha = 0
        
        yesImageView.tintColorDidChange()

        
    }
    
    func moveRight() {
        let newCenter: CGPoint = CGPoint.init(x: 600, y: self.center.y)
        self.yesImageView.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
            self.center = newCenter
            self.transform = CGAffineTransform(rotationAngle: 1)
        }, completion: {
            (value: Bool) in
            self.removeFromSuperview()
        })
    }
    
    
    func moveLeft() {
        let newCenter: CGPoint = CGPoint.init(x: -600, y: self.center.y)
        self.noImageView.alpha = 1
        UIView.animate(withDuration: 0.3, delay: 0.3, options: [], animations: {
            self.center = newCenter
            self.transform = CGAffineTransform(rotationAngle: 1)
        }, completion: {
            (value: Bool) in
            self.removeFromSuperview()
        })
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
            
            if location.x == originalViewCenter.x {
                yesImageView.alpha = 0
                noImageView.alpha = 0
            } else if location.x < originalViewCenter.x  {
                yesImageView.alpha = 0
                noImageView.alpha = 1
            } else {
                yesImageView.alpha = 1
                noImageView.alpha = 0
            }
            
            contentView.transform = CGAffineTransform(rotationAngle: angle.degreesToRadians)
            contentView.center = CGPoint(x: originalViewCenter.x + translation.x, y: originalViewCenter.y)
            break
        case.ended:
            var newCenter: CGPoint = originalViewCenter
            if translation.x > panXLimit { // Move off to right
                newCenter.x = offScreenX
                self.removeFromSuperview()
                self.yesImageView.alpha = 1
                delegate.swipedRight(place: place)
            } else if translation.x < -panXLimit { // Move off to left
                newCenter.x = -offScreenX
                self.removeFromSuperview()
                self.noImageView.alpha = 1
                delegate.swipedLeft(place: place)
            } else {
                contentView.transform = CGAffineTransform.identity
                yesImageView.alpha = 0
                noImageView.alpha = 0
            }
            UIView.animate(withDuration: 0.3, animations: {
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
