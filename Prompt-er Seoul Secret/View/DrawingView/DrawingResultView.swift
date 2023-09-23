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
    
    // 뷰모델
    @StateObject var viewModel: shareViewModel
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
        .onAppear {
            print("drawingManager.voiceCount : \(drawingManager.voiceCount)")
        }
        .toolbar(.hidden)
        .overlay(content: {
            NavigationBar(title: "작품 기록보기", leftComponent:  {
                EmptyView()
            }) {
                Button {
                    drawingManager.saveToJson(directoryUrl: try! drawingManager.createDirectory(name: name, date: date))
                    goNextPage = true
                } label: {
                    Text(drawingManager.report.recordSummary.count != drawingManager.voiceCount || !drawingManager.isColorSummaryDone || !drawingManager.isSummaryDone ? "저장중..." : "보러가기")
                        .font(.pretendardSemiBold24)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(drawingManager.report.recordSummary.count != drawingManager.voiceCount || !drawingManager.isColorSummaryDone || !drawingManager.isSummaryDone ? Color.primary300 : Color.primary700)
                        .cornerRadius(10)
                }
                .disabled(drawingManager.report.recordSummary.count != drawingManager.voiceCount || !drawingManager.isColorSummaryDone || !drawingManager.isSummaryDone)
            }
        })
        .navigationDestination(isPresented: $goNextPage, destination: {
            CounselingView(report: drawingManager.report, viewModel: viewModel)
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
