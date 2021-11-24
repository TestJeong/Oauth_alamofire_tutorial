//
//  AuthApServicei.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire
import Combine

// 사용자 관련 api 호출
// 현재 사용자 정보, 모든 사용자 가져오기

enum UserApiService  {
   // static func login(email: String, password: String) ->
    
    // 현재 사용자 정보
    static func fetchCurrentUserInfo() -> AnyPublisher<UserData, AFError>{
        print("AuthApiService - register() called")
        
        let storedTokenData = UserDefaultsManager.shared.getTokens()
        
        let credential = OAuthCredential(accessToken: storedTokenData.accessToken,
                                         refreshToken: storedTokenData.refreshToken,
                                         expiration: Date(timeIntervalSinceNow: 30))
        
        // Create the interceptor
        let authenticator = OAuthAuthenticator()
        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
                                                        credential: credential)
        
        
        return ApiClient.shared.session
            .request(UserRouter.fetchCurrentUserInfo, interceptor: authInterceptor)
            .publishDecodable(type: UserInfoResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults 또는 keychain에 저장하며 현재는 userdefaults에 저장
           
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    // 학교 정보
    static func school_info(schoolName : String) -> AnyPublisher<SchoolInformation, AFError>{
        print("AuthApiService - register() called")
//        let dataas = KeychainHelper.standard.read(service: "refresh,access", account: "localLogin",type: TestData.self)!
//        let credential = OAuthCredential(accessToken: dataas.access,
//                                         refreshToken: dataas.refresh,
//                                         expiration: Date(timeIntervalSinceNow: 30000))
//        // Create the interceptor
//        let authenticator = OAuthAuthenticator()
//        let authInterceptor = AuthenticationInterceptor(authenticator: authenticator,
//                                                        credential: credential)
        print("A\((UserRouter.school_info(schoolName: schoolName)))")
        return
            AF.request(UserRouter.school_info(schoolName: schoolName))
            .publishDecodable(type: SchoolInformation.self)
            .value()
            .map{ receviedValue in
                print("유저 에이피아이 서비스에서 호출합니다\(receviedValue)")
                return receviedValue
                
            }.eraseToAnyPublisher()
    }
    
    func getTest() {
            let url = "https://jsonplaceholder.typicode.com/todos/1"
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: ["Content-Type":"application/json", "Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON { (json) in
                    //여기서 가져온 데이터를 자유롭게 활용하세요.
                    print(json)
            }
        }
}
