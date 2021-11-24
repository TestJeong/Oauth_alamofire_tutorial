//
//  RandomUserRowView.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/24.
//

import SwiftUI

struct RandomUserRowView : View {
    
    var randomUser : SchoolInformation
    
    init(_ randomUser : SchoolInformation) {
        self.randomUser = randomUser
    }
    
    var body: some View {
        HStack{
            
            Text("\(randomUser.school_name)")
                .fontWeight(.heavy)
                .font(.system(size: 25))
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .minimumScaleFactor(0.5)
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .leading).padding(.vertical)
    }
}

//struct RandomUserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RandomUserRowView()
//    }
//}
