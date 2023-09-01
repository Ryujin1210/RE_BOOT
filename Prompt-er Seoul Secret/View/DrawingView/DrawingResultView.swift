//
//  DrawingResultView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct DrawingResultView: View {
    let image: UIImage
    
    // 종료하기
    @State var doneButtonTapped = false
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
                        // 저장하기
                    }
                }
            }
            .alert("그리기 종료!", isPresented: $doneButtonTapped) {
                Button("취소", role: .cancel) {
                    // 돌아가기
                    doneButtonTapped = false
                }
                
                Button("확인", role: .destructive) {
                    // 레코딩 종료
                    recordManager.stopRecording()
                }
            } message: {
                Text("그림을 완성하셨나요?")
            }
    }
}

struct DrawingResultView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DrawingResultView(image: UIImage(named: "ColoringBookEx")!, recordManager: RecordManager())
        }
    }
}
