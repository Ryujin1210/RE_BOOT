//
//  DrawingResultView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct DrawingResultView: View {
    @EnvironmentObject var drawingManager: DrawingManager
    let image: UIImage
    let name: String
    let date: String
    @State var goNextPage = false
    // 종료하기
    @StateObject var recordManager: RecordManager
    @State var isTranscriptIssue = false
    var body: some View {
        ZStack {
            Color.bgPrimary300
                .ignoresSafeArea()
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 500)
                .shadow(color: .black.opacity(0.25), radius: 14, x: 0, y: 4)
        }
        .alert("데이터 수신중...", isPresented: $isTranscriptIssue, actions: {
            Button("잠시 기다릴게요") {
                isTranscriptIssue = false
            }
        })
        .toolbar(.hidden)
        .overlay(content: {
            NavigationBar(title: "내가 완성한 작품 보기", leftComponent:  {
                EmptyView()
            }) {
                Button {
                    if drawingManager.report.recordSummary.count == drawingManager.voiceCount {
                        drawingManager.saveToJson(directoryUrl: try! drawingManager.createDirectory(name: name, date: date))
                        goNextPage = true
                    } else {
                        isTranscriptIssue = true
                    }
                } label: {
                    Text("저장하기")
                        .font(.pretendardSemiBold24)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(drawingManager.report.recordSummary.count != drawingManager.voiceCount ? Color.primary300.opacity(0.3) : Color.primary700)
                        .cornerRadius(10)
                }
                .disabled(drawingManager.report.recordSummary.count != drawingManager.voiceCount)
            }
        })
        .navigationDestination(isPresented: $goNextPage, destination: {
            CounselingView(report: drawingManager.report)
        })
        .navigationBarBackButtonHidden()
    }
}
//
//struct DrawingResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            DrawingResultView(image: UIImage(named: "ColoringBookEx")!, recordManager: RecordManager())
//        }
//    }
//}
