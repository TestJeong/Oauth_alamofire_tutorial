//
//  AuthApServicei.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire
import Combine

//인증 관련 api 호출

enum AuthApiService {
   // static func login(email: String, password: String) ->
    
    // 회원가입
    static func register(name: String, email:String,password: String) -> AnyPublisher<UserData, AFError>{
        print("AuthApiService - register() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.register(name: name, email: email, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장
                // userdefaults 또는 keychain에 저장하며 현재는 userdefaults에 저장
                UserDefaultsManager.shared.setTokens(accessToken: receivedValue.token.accessToken,
                                                     refreshToken: receivedValue.token.refreshToken)
           
                return receivedValue.user
            }.eraseToAnyPublisher()
    }
    
    // 로그인
    static func login(email:String,password: String) -> AnyPublisher<TestData, AFError>{
        print("AuthApiService - register() called")
        
        return ApiClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .publishDecodable(type: TestData.self)
            .value()
            .map{ receivedValue in
                // 받은 토큰 정보 어딘가에 영구 저장. keychain에 저장
     
                KeychainHelper.standard.save( receivedValue, service: "refresh,access", account: "localLogin")
                return receivedValue
            }.eraseToAnyPublisher()
    }
}
