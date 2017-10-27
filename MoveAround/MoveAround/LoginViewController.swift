//
//  ViewController.swift
//  MoveAround
//
//  Created by Mohit Taneja on 10/10/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Parse
import ParseFacebookUtilsV4
import AVFoundation

class LoginViewController: UIViewController, LoginButtonDelegate {
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused: Bool = false

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .success(grantedPermissions: _, declinedPermissions:  _, token: _):
            print("logged in")
            self.getUserDetails()
            break;
        default:
            print("Could not login.")
            break
        }
    }

    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logged Out")
    }

    func getUserDetails() {
        let params = ["fields" : "id, email, first_name, last_name"]
        let graphRequest = GraphRequest(graphPath: "me", parameters: params)
        graphRequest.start {
            (urlResponse, requestResult) in

            switch requestResult {
            case .failed(let error):
                print("error in graph request:", error)
                break
            case .success(let graphResponse):
                if let responseDictionary = graphResponse.dictionaryValue {
                    if let userDict = responseDictionary as NSDictionary! {
                        User.currentUser = User(dictionary: userDict)
                        self.presentSignupVC()
                    }
                }
            }
        }
    }

    func presentSignupVC() {
        print("will present")

        if (AccessToken.current != nil) {
            PFFacebookUtils.logInInBackground(with: FBSDKAccessToken.current())
            print("Logged with parse.")
            let pfUser = PFUser.current()
            print(pfUser)
        }
        let _ = MARealm.realm() // Inits realm for later use

    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let theURL = Bundle.main.url(forResource:"login", withExtension: "mp4")

        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = .none

        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(prepItineraries(notification:)), name: REALM_READY, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        if (User.currentUser != nil) {
            self.presentSignupVC()
            return
        }


        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: 28)
        let loginButton = LoginButton(frame: rect, readPermissions: [ .publicProfile, .email ])
        loginButton.center = view.center
        loginButton.center.y += 20
        loginButton.delegate = self

        view.addSubview(loginButton)
    }

    @objc func prepItineraries(notification: Notification) {
        print("preparing itineraries")
        let currentUser = User.currentUser!
        if let realm = MARealm.realm() {
            let query = "userID = '\(currentUser.id!)'"
            let itineraries = realm.objects(RItinerary.self).filter(query)
            if (itineraries.count > 0) {
                Itinerary.currentItinerary = ItineraryAdapter.createFrom(rItinerary: itineraries.last! as RItinerary, user: currentUser)
                print("Found an itinerary")
                let itineraryStoryBoard = UIStoryboard(name: "Itinerary", bundle: nil)
                let itineraryVC = itineraryStoryBoard.instantiateViewController(withIdentifier: "ItineraryViewController") as! ItineraryViewController
                self.navigationController?.present(itineraryVC, animated: true, completion: nil)
                return
            } else {
                let signupStoryBoard = UIStoryboard(name: "Signup", bundle: nil)
                let signupVC = signupStoryBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
                self.navigationController?.present(signupVC, animated: true, completion: nil)
                return
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        avPlayer.play()
        paused = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        avPlayer.pause()
        paused = true
    }
}

