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
    func saveImage(image: UIImage, name: String, onSuccess: @escaping ((Bool) -> Void)) {
        // image를 jpeg 혹은 png로 변환
        guard let data: Data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }
        // 루트 디렉토리 찾기
        let rootDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // 저장 디렉토리 설정
        let toSaveDirectory = rootDirectory?.appendingPathComponent("users")
        
        let userDirectory = toSaveDirectory?.appendingPathComponent("\(name)-\(Date().description)")
        
        let userFile = userDirectory?.appendingPathComponent("user.txt")

        do {
            let exData = "Helelo"
            try FileManager.default.createDirectory(at: userDirectory!, withIntermediateDirectories: true)
            try data.write(to: userDirectory!.appendingPathComponent("image"))
        } catch {
            print("error: \(error)")
        }
//
//        if let directory: URL = try? FileManager.default.url(for: .documentDirectory,
//                                         in: .userDomainMask,
//                                         appropriateFor: nil,
//                                         create: false) {
//            do {
//                try data.write(to: directory.appendingPathComponent(name))
//                onSuccess(true)
//            } catch let error as NSError {
//                print("Could not saveImage🥺: \(error), \(error.userInfo)")
//                onSuccess(false)
//            }
//        }
    }
    
    // 캔버스에서 사용된 색 추출하기
    func getColors(canvas: PKCanvasView) {
        let strokes = canvas.drawing.strokes
        let colors = strokes.map { stroke in
            stroke.ink.color
        }
        
        let colorSet: Set = Set(colors)
        print(colorSet)
    }
}
