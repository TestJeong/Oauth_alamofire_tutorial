//
//  RegisterData.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/23.
//

import Foundation

    struct SchoolInformation:Codable, Identifiable  {
        var uuid : UUID = UUID()
        var id : Int
        var school_name : String
        var school_address: String
        var school_education : String
        var school_type : Int
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case school_name = "school_name"
            case school_address = "school_address"
            case school_education = "school_education"
            case school_type = "school_type"

        }
 
    }
   


//struct SchoolInfo: Codable {
//    let school : [SchoolInformation]
//}
