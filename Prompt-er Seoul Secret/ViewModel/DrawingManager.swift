//
//  DrawingManager.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import PencilKit
import AVKit

class DrawingManager: ObservableObject {
    /// 음성 출력 관련 데이터
    // Singleton
    static let shared = DrawingManager()
    
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
    
    

}

// 음성 출력 관련 기능
extension DrawingManager {
    func playSound() {
        // 상황별 다른 음성 출력 가능하도록.
        guard let url = Bundle.main.url(forResource: "testSound", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("음원 재생 중 오류 발생 \(error)")
        }
    }
}

// 파일 관리 관련 데이터
extension DrawingManager {
    func saveData(name: String, recordSummary: String, canvas: PKCanvasView, image: UIImage) -> ReportModel? {
        // 날짜 정리
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        let today = dateFormatter.string(from: Date())
        
        // 사용 색상 get
        let colors = getColors(canvas: canvas)
        let mapColors = colors.map { color in
            CustomColor.init(uiColor: color)
        }
        // 레코드 파일 요약 (whisper, gpt 통신 필요)
        
        // 이미지 저장
        do {
            let userDirectory = try createDirectory(name: name, date: today)
            let imageURL = try saveImage(image: image, directoryUrl: userDirectory)
            // 레포트 모델 생성
            let reportModel = ReportModel(name: name, date: today, recordSummary: recordSummary, colors: mapColors, imageUrl: imageURL.path)
            
            // 레포트 모델 저장
            saveToJson(report: reportModel, directoryUrl: userDirectory)
            
            return reportModel
        } catch {
            print("이미지 저장 중 error : \(error)")
        }
        
        return nil
    }
    
    func saveToJson(report: ReportModel, directoryUrl: URL) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = try? encoder.encode(report)
        let jsonFileUrl = directoryUrl.appendingPathComponent("data.json")
        
        if let jsonData = jsonData {
            do {
                try jsonData.write(to: jsonFileUrl)
            } catch {
                print("제이슨 데이터 저장 에러 \(error)")
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

enum SaveError: Error {
    case imageParsingError
    case generateUrlError
}
