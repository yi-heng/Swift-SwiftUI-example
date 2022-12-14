//
//  v_TextEditor.swift
//  format
//
//  Created by 1 on 7/27/22.
//

import SwiftUI

struct v_TextEditor: View {
    
    @State private var fullText: String = "A view that can display and edit long-form text."
    
    var body: some View {
        
        VStack {
            Form {
                Text("TextEditor").font(.title3)
                
                TextEditor(text: $fullText)
                    .font(.custom("HelveticaNeue", size: 16))
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 300)
            }
        }
        .navigationTitle("TextEditor")
        .navigationBarTitleDisplayMode(.inline)
        .modifier(navBarViewCodeAndDocs(pageType: "SwiftUI",pageID: "TextEditor"))
    }
}

struct v_TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        v_TextEditor()
    }
}
