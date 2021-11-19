//
//  ApiClient.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire

//api 호출 클라이언트
final class ApiClient {
    static let shared = ApiClient() // 한번 썻던것을 계속씀
    // 이미 만들어져있는 shared 객체 에 접근해 메서드를 수행한다
    
    static let BASE_URL = "http://3.37.254.196:8000/api/v3"
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor() // application/json을 위한것
    ])
    
    let moniteors = [ApiLogger()] as [EventMonitor]
    
    var session : Session
    
    //ApiClient가 생성이 될때 session에 대한 값을 넣어준다(session을 만든다)
    init() {
        print("ApiClient - init() called")
        session = Session(interceptor: interceptors, eventMonitors: moniteors)
    }
}
