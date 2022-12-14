//
//  api_PhotosUI.swift
//  HelloSwift
//
//  Created by 1 on 8/6/22.
//

// PhontosPicker文档
// matching 可以选择相册照片类型。常用的值：.images .videos  .any(of: [.images, .videos])  .any(of: [.images, .not(.livePhotos)])

import SwiftUI
import PhotosUI

struct api_PhotosPicker: View {
    var body: some View {
        
        ScrollView {
            VStack(alignment: .center) {
                
                Text("本示例适用于iOS 16.0+，用到了PhotosPicker()")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .frame(height: 200)
                
                if #available(iOS 16.0, *) {
                    
                    choicePhoto(selectedNum: 3)
                    
//                    choiceVideo()
                }
            }
            .navigationTitle("PhotosPicker")
            .modifier(navBarViewCodeAndDocs(pageType: "API",pageID: "PhotosPickerPhoto"))
        }
    }
}

// 选择图片
@available (iOS 16.0, *)
struct choicePhoto: View {
    // 选择的照片数量，最多只能选9
    @State var selectedNum: Int = 9
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImageData: [Data] = []
    
    var body: some View {
        
        // 将选择的照片显示出来
        if !selectedImageData.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    ForEach(selectedImageData, id: \.self) { photoData in
                        if let img = UIImage(data: photoData) {
                            Image(uiImage: img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 100)
                        }
                    }
                }
                .frame(height: 150)
                .padding()
            }
        }
        
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: $selectedNum.wrappedValue,
            matching: .images,
            photoLibrary: .shared()
        ) {
            Label("选择照片", systemImage: "photo")
        }
        .tint(.purple)
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .onChange(of: selectedItems) { newItems in
            if !newItems.isEmpty {
                selectedImageData = []
            }
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        selectedImageData.append(data)
                    }
                }
            }
        }
    }
}


@available (iOS 16.0, *)
struct choiceVideo: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedVideoData: Data? = nil
    
    @State private var player = AVPlayer()
    
    var body: some View {
        // todo: play video
        if selectedVideoData != nil {
            
        }
        
        PhotosPicker(
            selection: $selectedItem,
            matching: .videos,
            label: {
                Label("选择视频", systemImage: "video")
            }
        )
        .tint(.primary)
        .controlSize(.large)
        .buttonStyle(.borderedProminent)
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    print(data)
                    selectedVideoData = data
                }
            }
        }
    }
}

struct api_PhotosPicker_Previews: PreviewProvider {
    static var previews: some View {
        api_PhotosPicker()
    }
}
