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

    
    var body : some View {
        VStack{
            Form { // 아이디
                Section(header: Text("아이디"), content: {
                    TextField("아이디", text : $emilInput).keyboardType(.emailAddress).autocapitalization(.none)

                })
                // 비밀번호
                Section(header: Text("비밀번호"), content: {
                    SecureField("비밀번호", text : $passwordInput).keyboardType(.default)
                    SecureField("비밀번호 확인", text : $passwordInput).keyboardType(.default)
                    
                })
                Section(header: Text("학년"), content: {
//                    Picker("Gender:", selection: $selected){
//                        Text("Male").tag(0)
//                        Text("Female").tag(1)
//                        Text("Male").tag(0)
//                    }
             
                })
                Section(header: Text("아이디"), content: {
                    TextField("아이디", text : $emilInput).keyboardType(.emailAddress).autocapitalization(.none)

                })
            
                
            }
            HStack {
                       Text("Gender")
                           .font(Font.headline)
                       RadioButtonGroups { selected in
                           print("Selected Gender is: \(selected)")
                       }
                   }.padding()
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
