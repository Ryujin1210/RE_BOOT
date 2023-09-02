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
            Image("Tree")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 641, height: 834)
            VStack {
                Text("원하는 활동을 말해주세요")
                    .font(.pretendardBold32)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 60)
                
                Button(action: {
                    viewModel.tag = 2
                }) {
                    Text("작품 만들기")
                        .font(.pretendardBold40)
                        .frame(width: 344, height: 220, alignment: .center)
                        .background(Color.btnGreen)
                    
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
                .padding()
                
                Button(action: {
                    
                }) {
                    Text("갤러리 보기")
                        .font(.pretendardBold40)
                        .frame(width: 344, height: 220, alignment: .center)
                        .background(Color.btnGreen)
                    
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
                .padding()
            }
        }
    }
}
