//
//  SecondView.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/01.
//

import SwiftUI
import AVFoundation

struct ThirdView: View {
    @State private var isButtonPressed = false // 버튼 상태를 추적하는 상태 변수
    @ObservedObject var whiperModel = WhisperViewModel()
    @ObservedObject var openaiModel = openAIViewModel()
    @StateObject var viewModel: shareViewModel
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder!
    @State private var result: String = ""
    @State private var audioPlayer: AVAudioPlayer?
    @State private var gptTranlation: String = ""
    @State private var gptEdit: String = ""
    @State var images: [UIImage] = []
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 720, height: 1002)
                .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 10)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: -0.5)
                        .stroke(.black.opacity(0.1), lineWidth: 1)
                )
                .rotationEffect(Angle(degrees: 90))
                .padding(.top, 114)
            
            VStack {
                Image("Tree")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 285, height: 215)
                
                Text("가장 행복했던 순간을 묘사해주세요")
                    .font(.pretendardBold40)
                    .padding(.bottom, 40)
                
                Text("예시")
                    .font(.pretendardBold24)
                    .foregroundColor(.primary700)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.primary300.opacity(0.3))
                    .cornerRadius(10)
                
                Text("넓은 마당이 있는 2층 집에 살 때,\n 마당에서 남편과 노을을 보며 사색을 즐겼던 순간이요.")
                    .font(.pretendardMedium28).opacity(0.5)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.captionText2)
                
                Button(action: {
                    if isButtonPressed {
                        generate()
                    } else {
                        startRecording()
                    }
                    isButtonPressed.toggle()                    
                }) {
                    VStack{
                        Image("Mic")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 65, height: 65)
                        Text(isButtonPressed ? "이야기가 끝나면 다시 버튼을 눌러주세요" : "버튼을 누르고 나서 이야기해주세요")
                            .font(.pretendardBold36)
                            .padding(.bottom, 20)
                        
                    }
                    .frame(width: 660 , height: 180)
                    .background(isButtonPressed ? Color.btnRed : Color.primary500) // 버튼 상태에 따라 배경색 변경
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .padding(20)
                }
                .padding(.top, 64)
            }
            .onAppear {
                startRecording()
                stopRecording()
                openaiModel.setup()
            }
        }
    }
    
    // MARK: - func
    // 녹음된 오디오를 재생하는 함수
    func playRecordedAudio() {
        guard let audioFileURL = audioRecorder?.url  else {
            print("Audio file URL is nil.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            // 녹음을 시작하기 전에 prepareToRecord()를 호출해야 합니다.
            if audioRecorder.prepareToRecord() {
                audioRecorder.record()
                if let audioFileURL = audioRecorder?.url {
                    if let fileSize = getFileSize(for: audioFileURL) {
                        print("File size: \(fileSize) bytes")
                    } else {
                        print("Failed to get file size.")
                    }
                } else {
                    print("Audio file URL is nil.")
                }
            } else {
                print("Could not prepare audio recorder")
            }
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
        } else {
            print("already stop")
        }
        
        if let audioFileURL = audioRecorder?.url {
            if let fileSize = getFileSize(for: audioFileURL) {
                print("File size: \(fileSize) bytes")
            } else {
                print("Failed to get file size.")
            }
        } else {
            print("Audio file URL is nil.")
        }
    }
    
    func saveImage(_ image: UIImage) {
        viewModel.addImage(image)
    }
    
    func generate() {
        if audioRecorder.isRecording {
            audioRecorder.stop()
            viewModel.tag = 4
        } else {
            print("already stop")
        }
        DispatchQueue.main.async {
            whiperModel.uploadAudio(fileURL: audioRecorder.url) { result in
                switch result {
                case .success(let response):
                    self.result = response
                    Task {
                        gptTranlation = await openaiModel.getChatResponse(prompt: ("\(response)" + "\n" + "Translate to English"))!
                        print(gptTranlation)
                        gptEdit = await openaiModel.getChatResponse(prompt: ("\(gptTranlation)" + "\n" + "summarize this sentence in one sentence for me to draw as a single scene"))!
                        print(gptEdit)
//                        images = await openaiModel.generateImage(prompt: ("\(gptEdit)" + ", for Coloring Book"))!
                        images = await openaiModel.generateImage(prompt: ("\(gptEdit)" + ", for Coloring Book"))!

                        for image in images {
                            saveImage(image)
                        }
                        viewModel.tag = 5
 
                    }
                    
                case .failure(let error):
                    self.result = "Error: \(error.localizedDescription)"
                }
            }
            
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getFileSize(for fileURL: URL) -> Int? {
        do {
            // 파일의 내용을 Data로 읽어옵니다.
            let fileData = try Data(contentsOf: fileURL)
            
            // Data의 크기를 바이트 단위로 반환합니다.
            let fileSize = fileData.count
            return fileSize
        } catch {
            print("Error reading file size: \(error.localizedDescription)")
            return nil
        }
    }
    
}
