//
//  v_contextMenu.swift
//  HelloSwift
//
//  Created by 1 on 9/11/22.
//

import SwiftUI

struct v_contextMenu: View {
    var body: some View {
        VStack {
            Text("contextMenu示例")
                .font(.title3)
                .padding()
                .contextMenu {
                    Button("♥️ - Hearts", action: {})
                    Button("♣️ - Clubs", action: {})
                    Button("♠️ - Spades", action: {})
                    Button("♦️ - Diamonds", action: {})
                }
            
            Text("长按即可看到效果")
                .font(.callout)
                .foregroundColor(.gray)
        }
        .navigationTitle("contextMenu")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(navBarViewCodeAndDocs(pageType: "SwiftUI",pageID: "contextMenu"))
    }
}

struct v_contextMenu_Previews: PreviewProvider {
    static var previews: some View {
        v_contextMenu()
    }
}
