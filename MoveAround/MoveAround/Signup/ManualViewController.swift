//
//  ManualViewController.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 11/9/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import LikeAnimation

class ManualViewController: UIViewController  {
    @IBOutlet var totalView: UIView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var goButton: UIButton!
    
    func runAnimation() {
        let likeAnimation = LikeAnimation(frame: CGRect(origin: totalView.center, size: CGSize(width: 60, height: 60)))
        likeAnimation.center = cardView.center
        likeAnimation.duration = 2.5
        likeAnimation.circlesCounter = 0
        likeAnimation.particlesCounter.main = 7
        likeAnimation.particlesCounter.small = 2
        likeAnimation.delegate = self
        
        // Set custom colors here
        likeAnimation.heartColors.initial = .red
        likeAnimation.heartColors.animated = .red
        likeAnimation.particlesColor = .orange
        
        totalView.addSubview(likeAnimation)
        likeAnimation.run()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 3, height: 3)
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowRadius = 4
        
        goButton.layer.cornerRadius = 22
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        runAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! InterestSelectionViewController
        vc.itinerary = Itinerary.currentItinerary
    }

}


extension ManualViewController: LikeAnimationDelegate {
    
    func likeAnimationWillBegin(view: LikeAnimation) {
        //print("Like animation will start")
    }
    
    func likeAnimationDidEnd(view: LikeAnimation) {
        //print("Like animation ended")
        runAnimation()
    }
}
