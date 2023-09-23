//
//  ConversationAnalysisView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/23.
//

import SwiftUI

struct ConversationAnalysisView: View {
    @State private var isPopoverVisible = false
    
    let report: ReportModel
    let rebootBot: [String] = [
        "안녕하세요! 리붓봇이에요. 지금부터 저와 함께 대화하며 자유롭게 색칠을 해볼까요? 색칠하는 동안의 대화내용은 기록이 될 거에요.",
        "지금 색칠하고 있는 색을 고른 이유를 알려주세요!",
        "그 순간이 행복했던 이유가 무엇인가요?",
        "너무 잘 들었어요. 그 이후의 이야기가 궁금해요!",
        "그 외"
    ]
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 4) {
                Text("대화 내용 분석")
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
                        Text("대화 내용 분석")
                            .font(.pretendardSemiBold20)
                            .foregroundColor(.defaultBlack)
                            .padding(.bottom, 12)
                        
                        Text("어르신이 채색활동을 진행하시면서 리붓봇과 나눈 대화 \n내용을 통해, 어르신의 현재 심리상태와 정서상태를 파악 \n할 수 있어요.")
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
            .padding(.bottom, 48)
            
            HStack(spacing: 0) {
                Text("대화 내용 요약")
                    .font(.pretendardSemiBold28)
                    .foregroundColor(.defaultBlack)

                Spacer()
            }
            .padding(.bottom, 24)
            
            HStack(spacing: 0) {
                Text("대화 내용 요약 한 문단")
                    .font(.pretendardMedium24)
                    .foregroundColor(.bodyText)

            }
            .padding(.bottom, 72)
            
            // 긍정 부정 단어 박스
            HStack {
                // 긍정 단어 개수
                VStack {
                    HStack {
                        Text("긍정단어")
                            .font(.pretendardMedium20)
                            .foregroundColor(.defaultBlack)
                            .background(Color.greenhi)
                    
                        
                        Text("개수")
                            .font(.pretendardMedium20)
                            .foregroundColor(.defaultBlack)
                        
                        Spacer()
                    }
                    .padding(.leading, 36)
                    .padding(.bottom, 50)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Spacer()
                        Text("\(report.sentenceCount)")
                            .font(.pretendardSemiBold40)
                            .padding(.trailing, 11)
                            .foregroundColor(.primary700)
                        
                        Text("문장")
                            .font(.pretendardMedium24)
                            .foregroundColor(.captionText1)
                            .padding(.trailing, 28)
                            .padding(.bottom, 9)
                    }
                }
               
                // 부정 단어 개수
                VStack {
                    HStack {
                        Text("부정단어")
                            .font(.pretendardMedium20)
                            .foregroundColor(.defaultBlack)
                            .background(Color.redhi
                                )
                    
                        
                        Text("개수")
                            .font(.pretendardMedium20)
                            .foregroundColor(.defaultBlack)
                        
                        Spacer()
                    }
                    .padding(.leading, 36)
                    .padding(.bottom, 50)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Spacer()
                        Text("\(report.sentenceCount)")
                            .font(.pretendardSemiBold40)
                            .padding(.trailing, 11)
                            .foregroundColor(.primary700)
                        
                        Text("문장")
                            .font(.pretendardMedium24)
                            .foregroundColor(.captionText1)
                            .padding(.trailing, 28)
                            .padding(.bottom, 9)
                    }
                }
            }
            .padding(.vertical, 24)
               
            
            Divider()
                .padding(.bottom, 48)
            
            HStack {
                Text("대화 내용 전체 보기")
                    .font(.pretendardBold28)
                    .foregroundColor(.defaultBlack)
                
                Spacer()
            }
            .padding(.bottom, 24)
            
            if !report.recordSummary.isEmpty {
                ForEach(0..<report.recordSummary.count) { num in
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("리붓봇")
                                .font(.pretendardBold24)
                                .fontWeight(.bold)
                                .foregroundColor(.primary700)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.primary300)
                                .cornerRadius(10)
                            
                            Text(rebootBot[num])
                                .font(.pretendardBold28)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .lineSpacing(12)
                            
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        Text(report.recordSummary[num]!)
                            .font(.pretendardMedium28)
                            .foregroundColor(.captionText1)
                            .lineSpacing(12)
                    }
                    .padding(.bottom, 52)
                    .frame(maxWidth: .infinity)
                }
            }
        }

    }
}
//
//struct ConversationAnalysisView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationAnalysisView(report: .init(name: "", date: "", recordSummary: [:], colors: [], imageUrl: "", firstAnswer: ""))
//    }
//}
//
//#Preview {
//    ConversationAnalysisView()
//}
