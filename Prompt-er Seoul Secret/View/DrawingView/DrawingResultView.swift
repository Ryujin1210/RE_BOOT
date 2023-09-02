//
//  DrawingResultView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct DrawingResultView: View {
    let image: UIImage
    let name: String
    let date: String
    @State var goNextPage = false
    // 종료하기
    @StateObject var recordManager: RecordManager
    
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
        .toolbar(.hidden)
        .overlay(content: {
            NavigationBar(title: "내가 완성한 작품 보기", leftComponent:  {
                EmptyView()
            }) {
                Button {
                    DrawingManager.shared.saveToJson(directoryUrl: try! DrawingManager.shared.createDirectory(name: name, date: date))
                    goNextPage = true
                } label: {
                    Text("저장하기")
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
        .navigationDestination(isPresented: $goNextPage, destination: {
            CounselingView(report: DrawingManager.shared.report)
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
