//
//  ProfileModel.swift
//  Rawg.io
//
//  Created by Leafy on 12/06/22.
//

import Foundation

struct ProfileModel {
    static let nameKey = "nameKey"
    static let emailKey = "emailKey"
    static let professionKey = "professionKey"
    
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "Evans Hebert"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }

    static var email: String {
        get {
            return UserDefaults.standard.string(forKey: emailKey) ?? "dabestevanzzacc@gmail.com"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }

    static var profession: String {
        get {
            return UserDefaults.standard.string(forKey: professionKey) ?? "iOS Developer"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: professionKey)
        }
    }

    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
