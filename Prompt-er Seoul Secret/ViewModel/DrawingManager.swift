//
//  DrawingManager.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import PencilKit
import AVKit

class DrawingManager: NSObject, ObservableObject, AVAudioPlayerDelegate {
    // 음성 입력
    var audioRecorder: AVAudioRecorder?
    @Published var isRecording = false
    
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    @Published var isPaused = false
    
    var recordedFiles = [URL]()
    
    var summaries: [String] = []
    
    // Singleton
    static let shared = DrawingManager()
    
    // 레포트 모델
    @Published var report: ReportModel = ReportModel(name: "", date: "", recordSummary: [:], colors: [], imageUrl: "", firstAnswer: "", mainColors: [], colorSummary: "", activityTime: "", summaryText: "")
    @Published var voiceCount: Int = 0
    // 질문 더미 데이터
    var drawingQuestion: [String] = [
        "가장 행복했던 순간을 묘사해주세요",
        "삶에서 나에게 영향을 준 사람을 묘사해보세요",
        "나의 이름 뜻을 묘사해주세요",
        "나의 첫 기억을 묘사해보세요",
        "생애 중 가장 어려웠던 기억을 묘사해보세요"
    ]
    
    var player: AVAudioPlayer?
    let painterName: String = "김복자"
    
    // 음성 녹음 관련 저장 프로퍼티
    @Published var audioRecordName: String = ""
    @Published var audioRecordDate: String = ""
    @Published var audioCounter: Int = 0
    
    // Flags
    @Published var isColorSummaryDone = false
}

// 음성 출력 관련 기능
extension DrawingManager {
    func playSound(soundNum: Int, name: String, date: String, fileCount: Int) {
        self.audioRecordName = name
        self.audioRecordDate = date
        self.audioCounter = fileCount
        
        // 상황별 다른 음성 출력 가능하도록.
        guard let url = Bundle.main.url(forResource: "OutPut\(soundNum)", withExtension: ".m4a") else { return }
        
        print("음성. 출력 OutPut\(soundNum)")
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
        } catch {
            print("음원 재생 중 오류 발생 \(error)")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        startRecording(name: audioRecordName, date: audioRecordDate, fileCount: audioCounter)
    }
}

// 파일 관리 관련 데이터
extension DrawingManager {
    func saveData(name: String, canvas: PKCanvasView, image: UIImage, date: String, voiceCount: Int, firstAnswer: String, activityTime: Int) {
        print(voiceCount)
        self.voiceCount = voiceCount
        // 사용 색상 get
        let colors = getColors(canvas: canvas)
        let mapColors = colors.map { color in
            CustomColor.init(uiColor: color)
        }
        
        // Main Color get
        let mainColors = getMainColors(canvas: canvas)
        let mapMainColors = mainColors.map { color in
            CustomColor.init(uiColor: color)
        }
        
        Task {
            print("컬러요약")
            guard let result = await openAIViewModel.shared.getColorChatResponse(firstAnswer: firstAnswer, colors: mainColors) else { return }
            print("컬러요약 \(result)")
            self.report.colorSummary = result
            isColorSummaryDone = true
        }
        
        // 이미지 저장
        do {
            let userDirectory = try createDirectory(name: name, date: date)
            let imageURL = try saveImage(image: image, directoryUrl: userDirectory)
            
            for i in 0...voiceCount {
                let voice = userDirectory.appendingPathComponent("\(i).m4a")
                WhisperViewModel().uploadKoreanAudio(fileURL: voice, completion: { result in
                    switch result {
                    case .success(let success):
                        Task {
                            var editText =  await openAIViewModel.shared.getEditorChatResponse(prompt: success)
                            self.report.recordSummary.updateValue(editText ?? "응답 에러", forKey: i)
                        }
                        // 여기서 마침표 구문점 넣기
                        print("voiceCount : \(self.report.recordSummary.count)")
                    case .failure(let failure):
                        print("error: \(failure.localizedDescription)")
                    }
                    
                })
            }

            // 레포트 모델 생성
            self.report.name = name
            self.report.date = date
            self.report.colors = mapColors
            self.report.imageUrl = imageURL.path
            self.report.firstAnswer = firstAnswer
            self.report.mainColors = mapMainColors
            self.report.activityTime = activityTime.secondsToTimeString()
            
            // 레포트 모델 저장
//            saveToJson(report: reportModel, directoryUrl: userDirectory)
        } catch {
            print("이미지 저장 중 error : \(error)")
        }
    }
    
    func saveToJson(directoryUrl: URL) {
        Task {
            var allText: String = ""
            
            for part in report.recordSummary {
                allText += part.value
            }
            
            if let summary = await openAIViewModel.shared.getSummarizeChatResponse(prompt: allText) {
                report.summaryText = summary
            }
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try? encoder.encode(self.report)
            let jsonFileUrl = directoryUrl.appendingPathComponent("data.json")
            
            if let jsonData = jsonData {
                do {
                    try jsonData.write(to: jsonFileUrl)
                } catch {
                    print("제이슨 데이터 저장 에러 \(error)")
                }
            }
        }
    }
    
    func saveImage(image: UIImage, directoryUrl: URL) throws -> URL {
        // image를 jpeg로 변환
        guard let data: Data = image.jpegData(compressionQuality: 1) else {
            throw SaveError.imageParsingError
        }
        
        let userFile = directoryUrl.appendingPathComponent("image.jpeg")

        do {
            try data.write(to: userFile)
        } catch {
            print("이미지 저장 error: \(error)")
            throw error
        }
        
        return userFile
    }
    
    func saveColors(canvas: PKCanvasView, name: String) {
        let data = "\(getColors(canvas: canvas))"
        do {
            let userDirectory = try createDirectory(name: name, date: "몇월 며칠")
            
            let userFile = userDirectory.appendingPathComponent("colors.txt")
            
            try data.write(to: userFile, atomically: false, encoding: .utf8)
        } catch {
            print("error : \(error)")
        }
    }
    
    // 캔버스에서 사용된 색 추출하기
    func getColors(canvas: PKCanvasView) -> [UIColor] {
        let strokes = canvas.drawing.strokes
        let colors = strokes.map { stroke in
            stroke.ink.color
        }
        
        let colorSet: Set = Set(colors)
        
        return Array(colorSet)
    }
    
    func getMainColors(canvas: PKCanvasView) -> [UIColor] {
        
        var candidateColor: [UIColor:CGFloat] = [:]
        let strokes = canvas.drawing.strokes
        print("----> strokeCount \(strokes.count)")
        
        for stroke in strokes {
            if candidateColor[stroke.ink.color] != nil {
                candidateColor[stroke.ink.color] = candidateColor[stroke.ink.color]! + stroke.renderBounds.width * stroke.renderBounds.height
            } else {
                candidateColor.updateValue(stroke.renderBounds.width * stroke.renderBounds.height, forKey: stroke.ink.color)
            }
        }
        print("================ 색상 크기")
        print(candidateColor)
        
        if candidateColor.count <= 3 {
            return candidateColor.keys.map { color in
                color
            }
        }
        
        var mainColors: [UIColor] = []
        
        for _ in 0..<3 {
            if let color = candidateColor.max(by: { $0.value < $1.value }) {
                candidateColor.removeValue(forKey: color.key)
                mainColors.append(color.key)
            }
            print("----> mainColors \(mainColors)")
        }
        
        return mainColors
    }
    
    func createDirectory(name: String, date: String) throws -> URL {

        
        // 루트 디렉토리 찾기
        let rootDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // 저장 디렉토리 설정
        let toSaveDirectory = rootDirectory?.appendingPathComponent("users")
        
        guard let userDirectory = toSaveDirectory?.appendingPathComponent("\(name)-\(date)") else {
            throw SaveError.generateUrlError
        }
        
        // 디렉토리 생성
        do {
            try FileManager.default.createDirectory(at: userDirectory, withIntermediateDirectories: true)
        } catch {
            print("디렉토리 생성 에러error: \(error)")
        }
        
        // 유저디렉토리 리턴
        return userDirectory
    }
}

// 음성 녹음 관련 메서드
extension DrawingManager {
    func startRecording(name: String, date: String, fileCount: Int) {
        // 파일 저장 경로
        let fileURL = try? createDirectory(name: name, date: date) // 내담자 이름으로 파일 저장이 가능하도록 변경
        guard let audioFile = fileURL?.appendingPathComponent("\(fileCount).m4a") else { return }
        
        // Setting 값 저장
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: settings)
            audioRecorder?.record()
            self.isRecording = true
        } catch {
            print("녹음 오류 \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        self.recordedFiles.append(self.audioRecorder!.url)
        self.isRecording = false
    }
    
    private func getDocumentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
      return paths[0]
    }
}

enum SaveError: Error {
    case imageParsingError
    case generateUrlError
}
