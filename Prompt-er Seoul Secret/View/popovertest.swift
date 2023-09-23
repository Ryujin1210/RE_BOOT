//
//  popovertest.swift
//  Prompt-er Seoul Secret
//
//  Created by YU WONGEUN on 2023/09/24.
//

import SwiftUI

struct popovertest: View {
    @State private var isPopoverVisible = false
    var body: some View {
        
        // 사용 문장 수 popover
        HStack(alignment: .top, spacing: 4) {
            Text("사용 문장 수")
                .font(.pretendardBold32)
                .foregroundColor(.defaultBlack)
            
            // popover
            Button(action: {
                isPopoverVisible.toggle()
            }, label: {
                Image("info.circle")
                    .foregroundColor(.unselectedText)
            })
            .popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
                
                VStack (alignment: .leading){
                    Text("사용 문장 수")
                        .font(.pretendardSemiBold20)
                        .foregroundColor(.defaultBlack)
                        .padding(.bottom, 12)
                    
                    Text("어르신이 사용하신 문장 수가 많을수록 인지 및 말하기 활 \n동이 활발하게 이루어진다고 볼 수 있어요.")
                        .font(.pretendardMedium20)
                        .foregroundColor(.captionText2)
                }
                .padding(.leading ,28)
                .padding(.top, 24)
                .padding(.bottom, 24)
                .padding(.trailing, 28)
            }
            
            Spacer()
        }
        // 사용 단어 수 popover
        HStack(alignment: .top, spacing: 4) {
            Text("사용 단어 수")
                .font(.pretendardBold32)
                .foregroundColor(.defaultBlack)
            
            // popover
            Button(action: {
                isPopoverVisible.toggle()
            }, label: {
                Image("info.circle")
                    .foregroundColor(.unselectedText)
            })
            .popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
                
                VStack (alignment: .leading){
                    Text("사용 단어 수")
                        .font(.pretendardSemiBold20)
                        .foregroundColor(.defaultBlack)
                        .padding(.bottom, 12)
                    
                    Text("어르신이 사용하신 단어 가짓수가 다양할수록 어르신의 \n어휘 구사가 활발하시다고 볼 수 있어요.")
                        .font(.pretendardMedium20)
                        .foregroundColor(.captionText2)
                }
                .padding(.leading ,28)
                .padding(.top, 24)
                .padding(.bottom, 24)
                .padding(.trailing, 28)
            }
            
            Spacer()
        }
        // 총 작품활동 시간 popover
        HStack(alignment: .top, spacing: 4) {
            Text("총 작품활동 시간")
                .font(.pretendardBold32)
                .foregroundColor(.defaultBlack)
            
            // popover
            Button(action: {
                isPopoverVisible.toggle()
            }, label: {
                Image("info.circle")
                    .foregroundColor(.unselectedText)
            })
            .popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
                
                VStack (alignment: .leading){
                    Text("총 작품활동 시간")
                        .font(.pretendardSemiBold20)
                        .foregroundColor(.defaultBlack)
                        .padding(.bottom, 12)
                    
                    Text("총 작품활동 시간으로 어르신께서 활동을 수행하는 데에 \n소요되는 시간을 측정하여, 활동에 어려움을 느끼시는지 \n확인할 수 있어요.")
                        .font(.pretendardMedium20)
                        .foregroundColor(.captionText2)
                }
                .padding(.leading ,28)
                .padding(.top, 24)
                .padding(.bottom, 24)
                .padding(.trailing, 28)
            }
            
            Spacer()
        }

        // 사용된 색상 분석 popover
        HStack(alignment: .top, spacing: 4) {
            Text("사용된 색상 분석")
                .font(.pretendardBold32)
                .foregroundColor(.defaultBlack)
            
            // popover
            Button(action: {
                isPopoverVisible.toggle()
            }, label: {
                Image("info.circle")
                    .foregroundColor(.unselectedText)
            })
            .popover(isPresented: $isPopoverVisible, arrowEdge: .top) {
                
                VStack (alignment: .leading){
                    Text("사용된 색상 분석")
                        .font(.pretendardSemiBold20)
                        .foregroundColor(.defaultBlack)
                        .padding(.bottom, 12)
                    
                    Text("사용된 색상을 미술치료 관점으로 분석하여 사용자의 \n심리 상태를 파악합니다.")
                        .font(.pretendardMedium20)
                        .foregroundColor(.captionText2)
                }
                .padding(.leading ,28)
                .padding(.top, 24)
                .padding(.bottom, 24)
                .padding(.trailing, 28)
            }
            
            Spacer()
        }

        
        
    }
}

struct popovertest_Previews: PreviewProvider {
    static var previews: some View {
        popovertest()
    }
}
