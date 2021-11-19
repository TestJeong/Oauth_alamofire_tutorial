//
//  ContentView.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                Image(systemName: "highlighter")
                    .font(.system(size:160))
                Spacer()
                // destination : 넘어가는 화면
                // label : 실제 보여지는 화면
                NavigationLink(destination: LoginView(), label: {
                    HStack{
                        Spacer()
                        Text("로그인 하러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }).padding([.bottom], 10)
                NavigationLink(destination: RegisterView(), label: {
                    HStack{
                        Spacer()
                        Text("회원가입 하러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                Spacer().frame(height:40)
               
                NavigationLink(destination: ProfileView(), label: {
                    HStack{
                        Spacer()
                        Text("내 프로필 보러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }).padding([.bottom], 10)
                NavigationLink(destination: Text("사용자 목록"), label: {
                    HStack{
                        Spacer()
                        Text("사용자 목록 보러가기")
                        Spacer()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                })
                Spacer()
                Spacer()
            } //VStack
            .padding()
        }// NavigationView
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
