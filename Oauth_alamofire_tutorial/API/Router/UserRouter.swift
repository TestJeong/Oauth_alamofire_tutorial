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
        case let .school_info(schoolName):
            return "/search/school?school_name=\(schoolName)"
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
    
    func asURLRequest() throws -> URLRequest {

        let urlPlus = "\(baseURL)\(endPoint)"
        let urlEncoding = urlPlus.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlEncoding!)

        var request = URLRequest(url: url!)
            request.method = method
     
            return request
    }
}
