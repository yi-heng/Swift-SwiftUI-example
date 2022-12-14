//
//  v_popover.swift
//  format
//
//  Created by 1 on 7/30/22.
//

import SwiftUI

struct v_Popover: View {
    @State var isShowPopover: Bool = false
    
    var body: some View {
        VStack {
            Button("Click Show Popover", action: {
                self.isShowPopover.toggle()
            })
            .popover(isPresented: $isShowPopover) {
                Text("本窗口由.popover弹出")
            }
        }
        .navigationTitle(".popover")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(navBarViewCodeAndDocs(pageType: "SwiftUI",pageID: "popover"))
    }
}

struct v_Popover_Previews: PreviewProvider {
    static var previews: some View {
        v_Popover()
    }
}
