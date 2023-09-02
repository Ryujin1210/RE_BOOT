//
//  FirstView.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/02.
//

import SwiftUI

struct FirstView: View {
    @StateObject var viewModel: shareViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Image("icon-Text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 237, height: 60)
                Text("다시 색칠하며 이야기하는 하루")
                    .font(.pretendardBold20)
                    .foregroundColor(.captionText1)
            }
            .padding(.trailing, 50)
            VStack {
                Text("원하는 활동을 말해주세요")
                    .font(.pretendardBold32)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Button(action: {
                    viewModel.tag = 2
                }) {
                    Image("btnMake")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 220)
                        .cornerRadius(20)
                }
                
                Button(action: {
                    // 갤러리 보기
                }) {
                    Image("btnGallery")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 220)
                        .cornerRadius(20)
                }
                .padding()
            }
            .padding(.leading, 200)
            
        }
    }
}
