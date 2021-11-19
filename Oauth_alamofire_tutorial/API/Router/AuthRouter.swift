//
//   AuthRouter.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire

// 인증 라우터
// 회원가입, 로그인, 토큰 갱신
enum AuthRouter : URLRequestConvertible {
    case register(name: String, email: String, password: String)
    case login(email: String, password: String)
    case tokenRefresh
        
    var baseURL : URL {
        return URL(string: ApiClient.BASE_URL)!
    }
    var endPoint: String {
        switch self {
        case .register:
            return "user/register"
        case .login:
            return "/signin"
        case .tokenRefresh:
            return "user/token-refresh"
        default:
            return ""
        
        }
    }
    
    var method : HTTPMethod {
        switch self {
        //case .tokenRefresh: return .get
        default : return .post
        }
    }
    
    var paramters: Parameters {
        switch self {
            //첫번째 방법
        case let .login(email, password):
            var params = Parameters()
            params["username"] = email
            params["password"] = password
            return params
            // 두번째 방법
        case .register(let name, let email, let password):
            var params = Parameters()
            params["name"] = name
            params["email"] = email
            params["password"] = password
            return params
            
        case .tokenRefresh:
            var params = Parameters()
            let tokenData = UserDefaultsManager.shared.getTokens()
            params["refresh_token"] = tokenData.refreshToken
            return params
            
            
        }
       
    }
    // 최종적으로 url 만드는 작업
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url : url)
        
        request.method = method
        
        request.httpBody = try JSONEncoding.default.encode(request, with:paramters).httpBody
        
        return request
    
    }
}
