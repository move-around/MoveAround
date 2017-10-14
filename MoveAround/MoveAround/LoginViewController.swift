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

class LoginViewController: UIViewController {

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

