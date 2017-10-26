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
}

class PlaceSwipeableView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
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
                self.removeFromSuperview()
                delegate.swipedRight(place: place)
            } else if translation.x < -panXLimit { // Move off to left
                newCenter.x = -offScreenX
                self.removeFromSuperview()
                delegate.swipedLeft(place: place)
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
