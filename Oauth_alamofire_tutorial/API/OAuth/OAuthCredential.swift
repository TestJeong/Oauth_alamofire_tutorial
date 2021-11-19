//
//  OAuthCredential.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire

struct OAuthCredential : AuthenticationCredential {
    
    let accessToken : String
    
    let refreshToken : String
    
    let expiration: Date
    
    var requiresRefresh: Bool { Date(timeIntervalSinceNow: 60 * 5) > expiration }
}
