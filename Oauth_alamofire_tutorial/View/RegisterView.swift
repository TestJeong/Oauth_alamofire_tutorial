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
    
    @State private var selected : Int = 0
    
    @State var Modal : Bool = false
    
    
    var body : some View {
        VStack{
            // 아이디
            HStack{
                Text("아이디")
                    .padding()
                TextField("아이디를 입력하세요", text : $emilInput).keyboardType(.emailAddress).autocapitalization(.none)
                Button(action:{ print("버튼 클릭")},
                       label: {
                    Text("중복확인")
                    
                })
            }.padding()
            
            // 비밀번호
            HStack{
                Text("비밀번호")
                    .padding()
                SecureField("비밀번호", text : $passwordInput).keyboardType(.default)
            }.padding()
            
            // 비밀번호 확인
            HStack{
                Text("비밀번호 확인")
                    .padding()
                SecureField("비밀번호 확인", text : $passwordInput).keyboardType(.default)
            }.padding()
            
            // 학년 선택
            HStack {
                Text("학년")
                    .font(Font.headline)
                    .padding()
                RadioButtonGroups { selected in
                    print("Selected Gender is: \(selected)")
                }
            }.padding()
            
            
            TextField("_", text : $emilInput).keyboardType(.emailAddress).autocapitalization(.none)
            
            Button(action: {self.Modal = true
                
            }, label: {
                Text("학교선택")
            })
            .sheet(isPresented: $Modal,
                   onDismiss: {print("Dismissed")},
                   content : { PresentedViews() })
                    
            
            Button(action: {print("회원가입 버튼 클릭")
                userVM.register(name: nameInput, email: emilInput, password: passwordInput)
            }, label: {
                Text("회원가입하기")
            })
            
            
            // 이벤트가 왔을때 무엇인가 하겠다
                .onReceive(userVM.registerationSuccess, perform: {
                    print("RegisterView - registrationSuccess() called")
                })
        }.navigationTitle("회원가입")
    }
}




struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(UserVM())
    }
}
