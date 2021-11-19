//
//  File.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/17.
//

import Foundation
import SwiftUI

struct RegisterView : View {
    
    @EnvironmentObject var userVM : UserVM
    
    @Environment(\.dismiss) var dismiss
    
    @State var nameInput : String = ""
    @State var emilInput : String = ""
    @State var passwordInput : String = ""
    
    @State fileprivate var shouldShowAlert : Bool = false
    
    var body : some View {
        VStack{
            Form {
                // 이름
                Section(header: Text("이름"), content: {
                    TextField("이름을 입력해주세요..", text : $nameInput).keyboardType(.default)
                })
                // 이메일
                Section(header: Text("이메일"), content: {
                    TextField("이메일", text : $emilInput).keyboardType(.emailAddress).autocapitalization(.none)
                   
                    
                })
                // 비밀번호
                Section(header: Text("비밀번호"), content: {
                    SecureField("비밀번호", text : $passwordInput).keyboardType(.default)
                    SecureField("비밀번호 확인", text : $passwordInput).keyboardType(.default)
                    
                })
                Section {
                    Button(action: {print("회원가입 버튼 클릭")
                        userVM.register(name: nameInput, email: emilInput, password: passwordInput)
                    }, label: {
                        Text("회원가입하기")
                    })
                }
            }
            // 이벤트가 왔을때 무엇인가 하겠다
            .onReceive(userVM.registerationSuccess, perform: {
                print("RegisterView - registrationSuccess() called")
                self.shouldShowAlert = true
            })
            .alert("회원가입이 완료되었습니다.", isPresented: $shouldShowAlert){
                Button("확인", role: .cancel){
                    self.dismiss()
                }
            }
        }.navigationTitle("회원가입")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
