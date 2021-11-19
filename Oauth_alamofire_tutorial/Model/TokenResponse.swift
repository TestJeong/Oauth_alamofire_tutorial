//
//  File.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation

struct TokenResponse: Codable {
    let message : String
    let token : TokenData
}
