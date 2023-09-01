//
//  DrawingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    // Image 전달 받기
    let image: UIImage = UIImage(named: "ColoringBookEx")!
    @State var captureImage: UIImage?
    @State var isDone = false
    
    // 캔버스 관련 변수
    @State var canvas = PKCanvasView()
    @State var isPresented = false
    
    // 오디오 관련 프로퍼티
    @StateObject var recordManager = RecordManager()
    
    var body: some View {
        HStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(DrawingManager.shared.drawingQuestion, id: \.self) { question in
                        Text(question)
                            .font(.title)
                            .onAppear {
                                // 글과 맞는 음성 출력
//                                DrawingManager.shared.playSound()
                            }
                    }
                }
            }
            DrawingCanvasView(canvas: $canvas, isPresented: $isPresented, image: image)
            Button("색 추출") {
                DrawingManager.shared.getColors(canvas: canvas)
            }
            
            Button("파일저장") {
                captureImage = canvas.snapshot()
                DrawingManager.shared.saveImage(image: captureImage!, name: "김복자") { status in
                    print("저장 완 : \(status)")
                }
            }
        }
        .onAppear {
            // 레코딩 시작
//            recordManager.startRecording()
            isPresented = true
        }
        .navigationTitle("자유롭게 채색해주세요.")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $isDone, destination: {
            if let captureImage = captureImage {
                DrawingResultView(image: captureImage, recordManager: recordManager)
            } else {
                DrawingResultView(image: image, recordManager: recordManager)
            }
        })
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("완성") {
                    captureImage = canvas.snapshot()
                    isDone = true
                }
            }
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DrawingView()
        }
    }
}
