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
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .navigationTitle("내가 완성한 그림보기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장하기") {
                        DrawingManager.shared.saveToJson(directoryUrl: try! DrawingManager.shared.createDirectory(name: name, date: date))
                        goNextPage = true
                    }
                }
            }
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
