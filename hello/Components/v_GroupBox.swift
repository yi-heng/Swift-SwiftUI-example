//
//  v_GroupBox.swift
//  format
//
//  Created by 1 on 7/28/22.
//

import SwiftUI

struct v_GroupBox: View {
    @State private var isAgreed: Bool = true
    @State private var bodyContent: String = """
    在此特别提醒您（用户）在注册成为用户之前，请认真阅读本《隐私协议》（以下简称“协议”），确保您充分理解本协议中各条款。请您审慎阅读并选择接受或不接受本协议。您的注册、登录、使用等行为将视为对本协议的接受，并同意接受本协议各项条款的约束。本协议约定 我司与用户之间关于软件或服务的权利义务。“用户”是指注册、登录、使用本服务的个人。本协议可由本公司随时更新，更新后的协议条款一旦公布即代替原来的协议条款，恕不再另行通知，用户可在本公司产品中查阅最新版协议条款。在修改协议条款后，如果用户不接受修改后的条款，请立即停止使用本公司提供的服务，用户继续使用服务将被视为接受修改后的协议。
    """
    
    var body: some View {
        VStack {
            GroupBox(label:
                Label("隐私协议", systemImage: "building.columns")
            ) {
                ScrollView(.vertical, showsIndicators: true) {
                    Text(bodyContent)
                        .font(.footnote)
                }
                .frame(height: 200)
                Toggle(isOn: $isAgreed) {
                    Text("我同意")
                }
            }
        }
        .navigationTitle("GroupBox")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(navBarViewCodeAndDocs(pageType: "SwiftUI",pageID: "GroupBox"))
    }
}

struct v_GroupBox_Previews: PreviewProvider {
    static var previews: some View {
        v_GroupBox()
    }
}
