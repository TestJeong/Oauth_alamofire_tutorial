//
//   AuthRouter.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire

//사용자 라우터
// 현재 로그인한 사용자 정보, 모든 사용자 가져오기
enum UserRouter : URLRequestConvertible {
    case fetchCurrentUserInfo
    case fetchUsers
    case school_info(schoolName : String)

        
    var baseURL : URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    var endPoint: String {
        switch self {
        case .fetchUsers:
            return "user/all"
        case .fetchCurrentUserInfo:
            return "user/info"
        case .school_info:
            return "search/school?school_name=대동"
        default:
            return ""
        }
    }
    
    var method : HTTPMethod {
        switch self {
        //case .tokenRefresh: return .get
        default : return .get
        }
    }
    
//    var paramters: Parameters {
//        switch self {
//        case let .school_info(schoolName) :
//            var params = Parameters()
//            params["school_name"] = schoolName
//            return params
//        default : return Parameters()
//
//        }
//
//    }

    func asURLRequest() throws -> URLRequest {
       
        
        
        //let url = baseURL.appendingPathComponent(endPoint)
        var test = "http://3.37.254.196:8000/api/v3/search/school?school_name=대동"
        var hoho = test.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let url = URL(string: hoho!)

        var request = URLRequest(url : url!)
   
        request.method = method

//        AF.request(url,
//                   method: method,
//                   parameters: paramterss,
//                   encoding: URLEncoding.queryString,
//                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
//            .responseJSON { (json) in
//                //여기서 가져온 데이터를 자유롭게 활용하세요.
//                print("안녕하세요\(json)")
//        }
        let urla = "https://jsonplaceholder.typicode.com/todos/1"
        AF.request(hoho!,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                var routines: [SchoolInformation]
                print("? \(response)")
            }.resume()

        return request
    
    }
}
