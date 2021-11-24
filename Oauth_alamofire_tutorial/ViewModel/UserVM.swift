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
    // 계속 메모리에 데이터가 남아있기 때문에 해지할 필요가 있어 해지할때 사용 하는 메서드
    var subscription = Set<AnyCancellable>()
    
    @Published var loggedInUser : UserData? = nil
    @Published var TestInUser : TestData? = nil
    @Published var schoolList = [SchoolInformation]()
    
    // 회원가입 완료 이벤트
    var registerationSuccess = PassthroughSubject<(), Never>()
    
    // 로그인 완료 이벤트
    var loginSuccess = PassthroughSubject<(), Never>() // 데이터를 물고 있는 것이아니라 단방향으로 보낸다 아무것도 보내지 않을경우 () 한다
    
    init() {
        print("userVM에서 init 실행")
        helloapple()
    }
    
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
                print("값은 무엇일까요? : \(receivedUser)")
              
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
   // 검색한 학교 리스트 정보 가져오기
//    func fetchSchoolInformation(schoolName: String) {
//        print("UserVM - fetchSchoolInformation() called")
//        UserApiService.school_info(schoolName: schoolName)
//            .sink {(completion: Subscribers.Completion<AFError>) in
//            print("UserVM fetchSchoolInformation completion: \(completion)")
//        } receiveValue: { (receivedUser: SchoolInformation) in
//            print("UserVM fetchSchoolInformation receivedUser: \(receivedUser)")
//            self.schoolList = receivedUser
//        }.store(in: &subscription)
//    }
  
    func helloapple() {
        var test = "http://3.37.254.196:8000/api/v3/search/school?school_name=대동"
        var hoho = test.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

        let url = URL(string: hoho!)
        
        AF.request(url!)
                   .publishDecodable(type: [SchoolInformation].self)
                   .compactMap{ $0.value }
                   .map{ $0 }
                   .sink(receiveCompletion: { completion in
                       print("데이터스트림 완료 \(completion) ")
                   }, receiveValue: { receivedValue in
                       print("받은 값 : \(receivedValue)")
                       self.schoolList = receivedValue
                   }).store(in: &subscription)

    }
}

