//
//  MARealm.swift
//  MoveAround
//
//  Created by Gonzalo Maldonado Martinez on 10/26/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//

import Foundation
import RealmSwift

let REALM_READY = NSNotification.Name(rawValue: "REALM_READY")
class MARealm: NSObject {
    private static var _realm: Realm?
    // TODO: Create class func to behave like a singleton
    static func realm() -> Realm? {
        if (self._realm != nil) {
            return self._realm!
        }

        let username = "elg0nz+movearound@gmail.com"
        let password = "u$o437YiY4H8ECcY9ZN{f"
        let ipAddress = "192.241.204.143"
        let serverURL = URL(string: "http://\(ipAddress):9080")
        DispatchQueue.main.async {
            SyncUser.logIn(with: .usernamePassword(username: username, password: password), server: serverURL!) { (user, error) in
                if (error != nil) {
                    print(error!)
                    return
                }
                let configuration = Realm.Configuration(
                    syncConfiguration: SyncConfiguration(user: user!, realmURL: URL(string: "realm://\(ipAddress):9080/movearound")!)
                )
                self._realm = try! Realm(configuration: configuration)
                NotificationCenter.default.post(name: REALM_READY, object: nil)
            }
        }
        return nil
    }
}
