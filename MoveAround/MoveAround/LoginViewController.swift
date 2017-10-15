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
            break;
        default:
            print("Could not login.")
            break
        }
    }

    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Logged Out")
    }


  override func viewDidLoad() {
    super.viewDidLoad()
    let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
    loginButton.center = view.center

    view.addSubview(loginButton)
}

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

