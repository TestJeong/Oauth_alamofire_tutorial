//
//  TokenData.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation

struct TokenData : Codable {
    let tokenType: String = ""
    let expiresIn: Int = 0
    let accessToken, refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
