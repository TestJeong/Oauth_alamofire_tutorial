//
//  AuthResponse.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation

struct AuthResponse : Codable {
    var user : UserData
    var token : TokenData
    
    enum CodingKeys : String, CodingKey {
        case token
        case user
    }
}
