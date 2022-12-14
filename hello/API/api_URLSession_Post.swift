//
//  api_URLSession_Post.swift
//  HelloSwift
//
//  Created by 1 on 8/5/22.
//

import SwiftUI

struct api_URLSession_Post: View {
    
    @EnvironmentObject var network: NetworkMonitor
    
    @State var errorMsg: String = ""
    @State var reqString: String = "简体字"
    @State var resString: String = ""
    
    @State var showAlertForCheck: Bool = false
    
    @State var isNetworkError: Bool = false
    @State var isResError: Bool = false
    @State var resErrorMessage: String = ""
    
    var body: some View {
        Form {
            Section("请求 - request") {
                TextEditor(text: $reqString)
                    .frame(height: 100)
                    .cornerRadius(10)
                    .onChange(of: reqString, perform: { newValue in
                        let tmp = self.reqString.trimmingCharacters(in: .whitespacesAndNewlines)
                        if tmp.isEmpty {
                            self.resString = ""
                        }
                    })
            }
            
            Section("响应 - response") {
                TextEditor(text: $resString)
                    .cornerRadius(10)
                    .frame(height: 100)
            }
            
            Button("发起POST网络请求") {
                apiPost()
            }
            .alert("转换的内容不能为空",isPresented: $showAlertForCheck) { }
            .alert("网络不可用，请检查网络连接",isPresented: $isNetworkError) { }
            .alert(resErrorMessage,isPresented: $isResError) { }
            
            if !(self.errorMsg.isEmpty) {
                Text(self.errorMsg)
                    .foregroundColor(.pink)
            }
        }
        .navigationTitle("URLSession POST")
        .modifier(navBarViewCodeAndDocs(pageType: "API",pageID: "URLSessionPOST"))
    }
    
    func apiPost() {
        let tmp = self.reqString.trimmingCharacters(in: .whitespacesAndNewlines)
        if tmp.isEmpty {
            self.showAlertForCheck.toggle()
            return
        }
        
        let url:String = "https://0c1fa337-7340-4755-9bec-f766d7d31833.bspapp.com/swift_URLSession"
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 5
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("", forHTTPHeaderField: "Cookie")
        
        var body = ["content": ""]
        body.updateValue(self.reqString, forKey: "content")
        
        let bodyData = try? JSONSerialization.data(
            withJSONObject: body,
            options: []
        )
        request.httpBody = bodyData
        
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                self.isResError.toggle()
                self.resErrorMessage = "网络请求出错, \(String(describing: error))"
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200 ..< 530) ~= response.statusCode else { return }
            if response.statusCode != 200 {
                self.isResError.toggle()
                self.resErrorMessage = "Error: HTTP请求失败 \(response.statusCode)"
                return
            }
            
            var serverString: String = ""
            var errorMessage: String = ""
            do {
                let rawJson = try? JSONSerialization.jsonObject(with:data!, options: .mutableContainers)
                if rawJson == nil {
                    return
                }
                    
                let res = rawJson as! NSDictionary
                let statusCode = res["status"]
                
                if statusCode != nil && statusCode as! Int == 20000 {
                    serverString = res["content"] != nil ? res["content"] as! String : ""
                    if serverString == "" {
                        errorMessage = "出错了"
                    }
                } else {
                    errorMessage = res["msg"] != nil ? res["msg"] as! String : "出错了"
                }
            } catch {
                errorMessage = "代码执行异常"
            }
            
            DispatchQueue.main.async {
                self.resString = serverString
                self.errorMsg = errorMessage
            }
            
        }.resume()
    }
}

struct api_URLSession_Post_Previews: PreviewProvider {
    static var previews: some View {
        api_URLSession_Post()
    }
}
