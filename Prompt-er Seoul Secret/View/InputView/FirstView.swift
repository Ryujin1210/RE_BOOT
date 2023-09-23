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
        ZStack {
            
            HStack {
                Spacer()
                Rectangle()
                    .foregroundColor(.bgPrimary300)
                    .frame(width: UIScreen.main.bounds.width / 1.8 , height: UIScreen.main.bounds.height)
            }

            HStack(alignment: .center) {
                VStack(alignment: .center) {
                    Image("icon-Text")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 237, height: 60)
                    Text("다시 이야기하며 색칠하는 기억")
                        .font(.pretendardBold20)
                        .foregroundColor(.captionText1)
                }
                .padding(.trailing, 50)
                VStack {
                    Text("원하는 활동을 선택해주세요")
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
                        viewModel.tag = 7
                    }) {
                        Image("btnHistory")
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
}
