//
//  TestData.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/19.
//

import Foundation

struct TestData : Codable {

    let access: String
    let refresh: String
    
    enum CodingKeys: String, CodingKey {
        case access = "access"
        case refresh = "refresh"
   
    }
}
