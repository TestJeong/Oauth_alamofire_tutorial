//
//  Oauth_alamofire_tutorialApp.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/17.
//

import SwiftUI

@main
struct Oauth_alamofire_tutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserVM())
        }
    }
}
