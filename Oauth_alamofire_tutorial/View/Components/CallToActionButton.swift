//
//  CallToActionButton.swift
//  Oauth_alamofire_tutorial
//
//  Created by 정윤재 on 2021/11/20.
//

import SwiftUI

struct CallToActionButton: View {
    let title: String
    var showingArrow = false
    let action: () -> Void

    private enum Dimensions {
        static let labelSpacing: CGFloat = 14
        static let lineLimit = 1
        static let radius: CGFloat = 50.0
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer(minLength: Dimensions.labelSpacing)
                Text(LocalizedStringKey(title))
                    .padding(.vertical, Dimensions.labelSpacing)
                    .lineLimit(Dimensions.lineLimit)
                    .font(Font.body.weight(.semibold))
                if showingArrow {
                    Image(systemName: "arrow.right")
                        .font(Font.caption2.weight(.bold))
                }
                Spacer(minLength: Dimensions.labelSpacing)
            }
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(Dimensions.radius)
        }
    }
}


struct CallToActionButton_Previews: PreviewProvider {
    static var previews: some View {
        
  
              CallToActionButton(title: "Button", showingArrow: true, action: {})
              CallToActionButton(title: "Button", showingArrow: false, action: {})
          }
}
