//
//  BaseInterceptor.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire

class BaseInterceptor : RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        var request = urlRequest // 들어온 url 주소를 변수에 담음
        
        // 헤더 부분 넣어주기
//        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        print("베이스 인터셉트에서 호출합니다 => \(request)")
        
        completion(.success(request)) // 중요! 성공이 되었다고 알려주어야 함 정상적으로 url 주소를 받아오면 외부로 내보낸다
    }
}
//api를 호출할때 만약에 accessTOKEN이 만료되었을때 인터셉터에서 자동으로 " 아 너가 토큰이 만료되었으니 리프레시 토큰으로 엑세스 토큰을 재 발행 할게 " 이 과정을
//OAuthAuthenticator가 대신 실행해주는 것 
