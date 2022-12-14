//
//  v_RoundedRectangle.swift
//  HelloSwift
//
//  Created by 1 on 9/24/22.
//

import SwiftUI

struct v_RoundedRectangle: View {
    var body: some View {
        ScrollView {
            
            VStack(spacing: 30) {
                Text("以下示例是对 RoundedRectangle() 的应用。")
                    .foregroundColor(.gray)
                    .frame(height: 80, alignment: .center)
                
                // 示例1
                Section(header: Text("示例1：正方形 150x150")) {
                    
                    RoundedRectangle(cornerRadius: 0)
                        .fill(.red.opacity(0.4))
                        .frame(width: 150, height: 150)
                    
                }
                
                // 示例2
                Section(header: Text("示例2：正方形 150x150，圆角30")) {
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.red.opacity(0.4))
                        .frame(width: 150, height: 150)
                    
                }
                
                // 示例3
                Section(header: Text("示例3：RoundedRectangle().inset().stroke() 效果")) {
                    
                    RoundedRectangle(cornerRadius: 30)
                        .inset(by: 10)
                        .stroke(Color.yellow, lineWidth: 15)
                        .frame(width: 150, height: 150)
                    
                }
            }
            .padding()
        }
        .navigationTitle("RoundedRectangle()")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(navBarViewCodeAndDocs(pageType: "SwiftUI",pageID: "RoundedRectangle"))
    }
}

struct v_RoundedRectangle_Previews: PreviewProvider {
    static var previews: some View {
        v_RoundedRectangle()
    }
}
