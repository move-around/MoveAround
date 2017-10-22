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

class LoginViewController: UIViewController, LoginButtonDelegate {
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
        let params = ["fields" : "id, first_name, last_name"]
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
        let signupStoryBoard = UIStoryboard(name: "Signup", bundle: nil)
        let signupVC = signupStoryBoard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.present(signupVC, animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        if let current = User.currentUser {
            self.presentSignupVC()
        }

        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.center = view.center
        loginButton.delegate = self

        view.addSubview(loginButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

