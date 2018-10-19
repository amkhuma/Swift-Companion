//
//  User.swift
//  Swifty-Companion
//
//  Created by Andile MKHUMA on 2018/10/15.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    var image_url : String
    var login : String
    var correction_points : Int
    var wallet : Int
    var email : String
    var staff : Bool
    var cursus_users: [Cursers_users]
    var projects_users: [Projects_users]
    
    enum CodingKeys : String, CodingKey {
        case image_url
        case login
        case correction_points = "correction_point"
        case email
        case staff = "staff?"
        case wallet
        case cursus_users
        case projects_users
    }
    
}

struct Cursers_users : Decodable {
    var level: Double
    var skills : [Skillz]
}

struct Skillz : Decodable {
    var name: String
    var level: Double
}


struct Projects_users : Decodable  {
    var final_mark: Int?
    var validated : Bool?
    var project : Project
    
    enum CodingKeys : String, CodingKey{
        case final_mark
        case validated = "validated?"
        case project
    }
}

struct Project : Decodable {
    var slug : String?
}
