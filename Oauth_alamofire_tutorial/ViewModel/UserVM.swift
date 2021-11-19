//
//  UserVM.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/18.
//

import Foundation
import Alamofire
import Combine

// 뷰 에서 변경을 감지

class UserVM: ObservableObject {
    var subscription = Set<AnyCancellable>()
    
    @Published var loggedInUser : UserData? = nil
    @Published var TestInUser : TestData? = nil
    
    // 회원가입 완료 이벤트
    var registerationSuccess = PassthroughSubject<(), Never>()
    
    // 로그인 완료 이벤트
    var loginSuccess = PassthroughSubject<(), Never>() // 데이터를 물고 있는 것이아니라 단방향으로 보낸다 아무것도 보내지 않을경우 () 한다
    
    //회원가입 하기
    func register(name: String, email: String, password: String){
          print("UserVM: register() called")
          AuthApiService.register(name: name, email: email, password: password)
              .sink { (completion: Subscribers.Completion<AFError>) in
                  print("UserVM completion: \(completion)")
              } receiveValue: { (receivedUser: UserData) in
                  self.loggedInUser = receivedUser
                  self.registerationSuccess.send()
              }.store(in: &subscription)
      }
    
    // 로그인 하기
    func login( email:String, password: String){
        print("UserVM : register() called")
        AuthApiService.login( email: email, password: password)
            .sink {(completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedUser: TestData) in
                self.TestInUser = receivedUser
                self.loginSuccess.send()
            }.store(in: &subscription)
    }
    
    // 현재 사용자 정보 가져오기
    func fetchCurrentUserInfo() {
        print("UserVM - fetchCurrentUserInfo() called")
        UserApiService.fetchCurrentUserInfo()
            .sink {(completion: Subscribers.Completion<AFError>) in
            print("UserVM fetchCurrentUserInfo completion: \(completion)")
        } receiveValue: { (receivedUser: UserData) in
            print("UserVM fetchCurrentUserInfo receivedUser: \(receivedUser)")
            self.loggedInUser = receivedUser
        }.store(in: &subscription)
    }
}
