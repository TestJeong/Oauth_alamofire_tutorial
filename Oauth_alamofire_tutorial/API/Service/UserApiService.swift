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
}
