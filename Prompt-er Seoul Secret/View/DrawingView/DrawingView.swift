//
//  DrawingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI
import PencilKit
import PopupView

struct DrawingView: View {
    @EnvironmentObject var drawingManager: DrawingManager
    
    // Image 전달 받기
    @StateObject var viewModel: shareViewModel
    @State var captureImage: UIImage?
    @State var isDone = false
    @State var goNextPage = false
    
    // 캔버스 관련 변수
    @State var canvas = PKCanvasView()
    @State var isPresented = false
    @State var toolPicker = PKToolPicker()
    
    // 오디오 관련 프로퍼티
    @StateObject var recordManager = RecordManager()
    
    // 팝업 관련 프로퍼티
    @State var popup = false
    @State var botCounter = 0
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    let rebootBot: [String] = [
        "안녕하세요! 이제 자유롭게 색칠을 해볼까요?\n먼저 원하는 색을 골라보세요!",
        "지금 색칠하고 있는 색을 고른 이유를 알려주세요!",
        "그 순간이 행복했던 이유가 무엇인가요?",
        "너무 잘 들었어요.\n그 이후의 이야기가 궁금해요!"
    ]
    
    func rebootBotAction() {
        popup = true
        drawingManager.startRecording(name: viewModel.name, date: viewModel.date, fileCount: botCounter)
    }
    
    var body: some View {
        ZStack {
            Color.bgColoring
                .ignoresSafeArea()
            
            DrawingCanvasView(canvas: $canvas, isPresented: $isPresented, toolPicker: $toolPicker, image: viewModel.selectedImage!)
                .frame(width: 630, height: 630)
                .padding(.top, 70)
        }
        .onAppear {
            drawingManager.report = .init(name: "", date: "", recordSummary: [:], colors: [], imageUrl: "")
            // 레코딩 시작
            drawingManager.startRecording(name: viewModel.name, date: viewModel.date, fileCount: botCounter)
            isPresented = true
            
            rebootBotAction()
        }
        .onReceive(timer) { value in
            if botCounter > 3 {
                timer.upstream.connect().cancel()
            } else {
                botCounter += 1
                print(botCounter)
                drawingManager.stopRecording()
                rebootBotAction()
            }
        }
        .alert("색칠하기를 그만하시겠어요?", isPresented: $isDone) {
            Button("취소", role: .cancel) {
                // 돌아가기
                isDone = false
            }
            
            Button("확인", role: .destructive) {
                // 레코딩 종료
                timer.upstream.connect().cancel()
                drawingManager.stopRecording()
                
                // 그림 및 정보 저장
                captureImage = canvas.snapshot()
                drawingManager.saveData(name: viewModel.name, canvas: canvas, image: captureImage!, date: viewModel.date, voiceCount: botCounter + 1)
                goNextPage = true
            }
        } message: {
            Text("확인을 누르면 색칠하기가 종료됩니다.")
        }
        .toolbar(.hidden)
        .overlay(content: {
            NavigationBar(title: "자유롭게 채색해주세요.", leftComponent:  {
                EmptyView()
            }) {
                Button {
                    isDone = true
                    toolPicker.setVisible(false, forFirstResponder: canvas)
                } label: {
                    Text("완성")
                        .font(.pretendardSemiBold24)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(Color.primary700)
                        .cornerRadius(10)
                }

            }
        })
        .popup(isPresented: $popup, view: {
            FloatingView(message: rebootBot[botCounter > 3 ? 0 : botCounter])
                .shadow(color: .black.opacity(0.12), radius: 14, x: 0, y: 4)
            
        }, customize: {
            $0
                .closeOnTap(true)
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(3)
        })
        .navigationDestination(isPresented: $goNextPage, destination: {
            if let captureImage = captureImage {
                DrawingResultView(image: captureImage, name: viewModel.name, date: viewModel.date, recordManager: recordManager, viewModel: viewModel)
            } else {
                DrawingResultView(image: UIImage(named: "ColoringBookEx")!, name: "", date: "", recordManager: recordManager, viewModel: viewModel)
            }
        })
    }
}

//struct DrawingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            DrawingView(vie)
//        }
//    }
//}

extension DrawingView {
    private struct FloatingView: View {
        let message: String
        
        var body: some View {
            VStack(spacing: 8) {
                Text("리붓봇")
                    .font(.pretendardBold24)
                    .foregroundColor(.primary700)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color.primary300)
                    .cornerRadius(10)
                
                Text(message)
                    .font(.pretendardSemiBold30)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 795, height: 205)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}
