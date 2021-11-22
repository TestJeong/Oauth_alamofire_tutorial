//
//  File.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/17.
//

import Foundation
import SwiftUI

struct LoginView : View {
    
    @EnvironmentObject var userVM : UserVM
        
    @Environment(\.dismiss) var dismiss

    @State var emilInput : String = ""
    @State var passwordInput : String = ""
    
    @State fileprivate var shouldShowAlert : Bool = false
    
    var body : some View {
        VStack{
            Form {
                Section(header: Text("로그인 정보"), content: {
                    TextField("이메일", text : $emilInput).keyboardType(.emailAddress).autocapitalization(.none)
                    SecureField("비밀번호", text : $passwordInput).keyboardType(.default)
                    
                })
                Section {
                    Button(action: {print("로그인 버튼 클릭")
                        userVM.login(email: emilInput, password: passwordInput)
                    }, label: {
                        Text("로그인 하기")
                    })
                }
            }
            LoggedInView()

            // 이벤트가 왔을때 무엇인가 하겠다
            .onReceive(userVM.loginSuccess, perform: {
//                let dataas = KeychainHelper.standard.read(service: "refresh,access", account: "localLogin",type: TestData.self)!
//                print("엑세스 토큰 입니다 : \(dataas.access)")

                print("LoginView - loginSuccess() called")
                self.shouldShowAlert = true
            })
            .alert("로그인이 완료되었습니다.", isPresented: $shouldShowAlert){
                Button("확인", role: .cancel){
                    self.dismiss()
                }
            }
        }.navigationTitle("로그인 하기")
    }
}

struct LoggedInView : View {
    var body: some View {
        Text("Logged in!")
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
