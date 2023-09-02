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
    @State var goNextPage = false
    
    // Report
    @State var report: ReportModel?
    
    // 캔버스 관련 변수
    @State var canvas = PKCanvasView()
    @State var isPresented = false
    
    // 오디오 관련 프로퍼티
    @StateObject var recordManager = RecordManager()
    
    var body: some View {
        ZStack {
            Color("background-coloring")
            
            DrawingCanvasView(canvas: $canvas, isPresented: $isPresented, image: image)
                .frame(width: 630, height: 630)
        }
        .onAppear {
            // 레코딩 시작
//            recordManager.startRecording()
            isPresented = true
        }
        .alert("그리기 종료!", isPresented: $isDone) {
            Button("취소", role: .cancel) {
                // 돌아가기
                isDone = false
            }
            
            Button("확인", role: .destructive) {
                // 레코딩 종료
//                recordManager.stopRecording()
                
                // 그림 및 정보 저장
                captureImage = canvas.snapshot()
                report = DrawingManager.shared.saveData(name: "김춘자", recordSummary: "이것저것이것저것이것저것이것저것이것저것이것저것", canvas: canvas, image: captureImage!)
                print(report)
                goNextPage = true
            }
        } message: {
            Text("그림을 완성하셨나요?\n확인을 누르면 그리기가 종료됩니다.")
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("자유롭게 채색해주세요.")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $goNextPage, destination: {
            if let captureImage = captureImage, let report = report {
                DrawingResultView(image: captureImage, report: report, recordManager: recordManager)
            } else {
                DrawingResultView(image: image, report: .init(name: "", date: "", recordSummary: "", colors: [], imageUrl: ""), recordManager: recordManager)
            }
        })
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("완성") {
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
