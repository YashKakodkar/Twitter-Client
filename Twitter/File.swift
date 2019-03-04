//
//  File.swift
//  Twitter
//
//  Created by Yash Kakodkar on 3/3/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

class User {
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    private static var _current: User?
    var name: String?
    var screenName: String?
    var profileImageURL: String?
    var dictionary: [String: Any]?
    var tweetCount: Int?
    var followers: Int?
    var following: Int?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url_https"] as? String
        tweetCount = dictionary["statuses_count"] as? Int
        followers = dictionary["followers_count"] as? Int
        following = dictionary["friends_count"] as? Int
    }
    
    public var desciption: String {return self.name! + " " + self.screenName!}
    
}
