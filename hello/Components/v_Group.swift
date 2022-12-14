//
//  v_Group.swift
//  HelloSwift
//
//  Created by 1 on 9/22/22.
//

import SwiftUI

struct v_Group: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Group 用于将实例（视图等），收集到一组或一个单元中。如下示例, Group 包含了3个 Text , 对 Group 设置 .font() 后，所有Text样式都被改变。")
                .font(.callout)
                .foregroundColor(.gray)
                .frame(height: 90)
            
            Group {
                Text("SwiftUI")
                Text("Combine")
                Text("Swift System")
            }
            .font(.headline)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Group")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(navBarViewCodeAndDocs(pageType: "SwiftUI",pageID: "Group"))
    }
    
}

struct v_Group_Previews: PreviewProvider {
    static var previews: some View {
        v_Group()
    }
}
