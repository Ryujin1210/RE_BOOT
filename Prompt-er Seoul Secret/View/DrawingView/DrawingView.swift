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
    // Image 전달 받기
    @StateObject var viewModel: shareViewModel
    @State var captureImage: UIImage?
    @State var isDone = false
    @State var goNextPage = false
    
    // Report
    @State var report: ReportModel?
    
    // 캔버스 관련 변수
    @State var canvas = PKCanvasView()
    @State var isPresented = false
    @State var toolPicker = PKToolPicker()
    
    // 오디오 관련 프로퍼티
    @StateObject var recordManager = RecordManager()
    
    // 팝업 관련 프로퍼티
    @State var popup = false
    
    var body: some View {
        ZStack {
            Color("background-coloring")
                .ignoresSafeArea()
            
            DrawingCanvasView(canvas: $canvas, isPresented: $isPresented, toolPicker: $toolPicker, image: viewModel.selectedImage!)
                .frame(width: 630, height: 630)
                .padding(.top, 70)
        }
        .onAppear {
            // 레코딩 시작
//            recordManager.startRecording()
            isPresented = true
            popup = true
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
                report = DrawingManager.shared.saveData(name: viewModel.name, recordSummary: "이것저것이것저것이것저것이것저것이것저것이것저것", canvas: canvas, image: captureImage!)
                goNextPage = true
            }
        } message: {
            Text("그림을 완성하셨나요?\n확인을 누르면 그리기가 종료됩니다.")
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
                        .font(.custom("SF Pro", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(Color("primary-700"))
                        .cornerRadius(10)
                }

            }
        })
        .popup(isPresented: $popup, view: {
            FloatingView()
                .shadow(color: .black.opacity(0.12), radius: 14, x: 0, y: 4)
            
        }, customize: {
            $0
                .closeOnTap(true)
                .type(.floater())
                .position(.top)
                .animation(.spring())
                .autohideIn(10)
        })
        .navigationDestination(isPresented: $goNextPage, destination: {
            if let captureImage = captureImage, let report = report {
                DrawingResultView(image: captureImage, report: report, recordManager: recordManager)
            } else {
                DrawingResultView(image: viewModel.selectedImage!, report: .init(name: "", date: "", recordSummary: "", colors: [], imageUrl: ""), recordManager: recordManager)
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
        var body: some View {
            VStack(spacing: 8) {
                Text("리붓봇")
                    .font(.custom("", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Color("primary-700"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(Color("primary-300"))
                    .cornerRadius(10)
                
                Text("안녕하세요! 이제 자유롭게 색칠을 해볼까요?\n먼저 원하는 색을 골라보세요")
                    .font(.custom("", size: 30))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 795, height: 205)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}
