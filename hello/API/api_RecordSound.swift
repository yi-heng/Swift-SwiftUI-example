//
//  api_RecordSound.swift
//  HelloSwift 录音
//
//  Created by 1 on 8/13/22.
//

import SwiftUI
import Foundation
import AVFoundation

enum RecordStatus {
    case noStart
    case start
    case end
}

struct api_RecordSound: View {
    
    let recoder_manager = RecordManager()
    
    @State var duration: Double = 0
    @State var status: RecordStatus = .noStart
    
    var body: some View {
        VStack {
            
            HStack {
                Image(systemName: "waveform.path")
                Text("\(duration) 秒")
            }
            .offset(y: -40)
            
            if status == .noStart {
                Button(action: {
                    recoder_manager.beginRecord()
                    status = .start
                }, label: {
                    RecordButton(iconName: "mic.fill")
                })
            }
            
            if status == .start {
                Button(action: {
                    duration = recoder_manager.stopRecord()
                    status = .end
                }, label: {
                    RecordButton(iconName: "waveform.and.mic")
                })
            }
            
            if status == .end {
                HStack(spacing: 100) {
                    Button(action: {
                        recoder_manager.play()
                    }, label: {
                        RecordButton(iconName: "play.circle")
                    })
                    
                    Button(action: {
                        status = .noStart
                    }, label: {
                        RecordButton(iconName: "xmark.circle")
                    })
                }
            }
            
        }
        .padding()
        .navigationTitle("录音")
        .modifier(navBarViewCodeAndDocs(pageType: "API",pageID: "RecordSound"))
    }
}

// 录制按钮图标样式
struct RecordButton: View {
    @State var iconName = ""
    var body: some View {
        Image(systemName: iconName)
            .font(.largeTitle)
            .imageScale(.large)
    }
}

class RecordManager {
    
    var recorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    let file_path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/record2022.wav")
    
    //开始录音
    func beginRecord() {
        let session = AVAudioSession.sharedInstance()
        
        //设置session类型
        do {
            try session.setCategory(AVAudioSession.Category.playAndRecord)
        } catch let err{
            print("设置类型失败:\(err.localizedDescription)")
        }
        
        //设置session动作
        do {
            try session.setActive(true)
        } catch let err {
            print("初始化动作失败:\(err.localizedDescription)")
        }
        
        //录音设置，注意，后面需要转换成NSNumber，如果不转换，则无法录制音频文件
        let recordSetting: [String: Any] = [
            AVSampleRateKey: NSNumber(value: 16000),   //采样率
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),   //音频格式
            AVLinearPCMBitDepthKey: NSNumber(value: 16),   //采样位数
            AVNumberOfChannelsKey: NSNumber(value: 1),     //通道数
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)  //录音质量
        ];
        
        //开始录音
        do {
            let url = URL(fileURLWithPath: file_path!)
            recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            recorder!.prepareToRecord()
            recorder!.record()
            print("开始录音")
        } catch let err {
            print("录音失败:\(err.localizedDescription)")
        }
    }
    
    //结束录音，并返回录音时长
    func stopRecord() -> Double {
        var duration: Double = 0
        if let recorder = self.recorder {
            if recorder.isRecording {
                print("录音结束，文件保存到：\(file_path!)")
            }
            recorder.stop()
            self.recorder = nil
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: file_path!))
            duration = player!.duration
        } catch {}
        return duration
    }
    
    //开始播放
    func play() {
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: file_path!))
            player!.play()
        } catch let err {
            print("播放失败:\(err.localizedDescription)")
        }
    }
}

struct api_RecordSound_Previews: PreviewProvider {
    static var previews: some View {
        api_RecordSound()
    }
}
