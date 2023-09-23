//
//  CounselingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

enum AnalysisViewType: Int {
    case conversation = 0
    case color
}

struct CounselingView: View {
    let report: ReportModel
    var isButtonNonVisible = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: shareViewModel
    
    @State var nowPresenting: AnalysisViewType = .conversation
    
    let rebootBot: [String] = [
        "안녕하세요! 리붓봇이에요. 지금부터 저와 함께 대화하며 자유롭게 색칠을 해볼까요? 색칠하는 동안의 대화내용은 기록이 될 거에요.",
        "지금 색칠하고 있는 색을 고른 이유를 알려주세요!",
        "그 순간이 행복했던 이유가 무엇인가요?",
        "너무 잘 들었어요. 그 이후의 이야기가 궁금해요!",
        "그 외"
    ]
    
    var body: some View {
        ZStack {
            Color("background")
            
            ScrollView {
                VStack {
                    ZStack {
                        Color.white
                            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 10)
                        
                        VStack {
                            Text("\(report.name)님의 가장 행복했던 기억")
                                .font(.pretendardBold28)
                                .foregroundColor(.primary900)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Color.primary300)
                                .cornerRadius(10)
                                .padding(.bottom, 24)
                            
                            Text(report.firstAnswer)
                                .font(.pretendardSemiBold28)
                                .padding(.bottom, 54)
                            
                            Image(uiImage: report.uiImage)
                                .resizable()
                                .frame(width: 514, height: 514)
                                .shadow(color: .black.opacity(0.14), radius: 14, x: 0, y: 0)
                                .padding(.bottom, 72)
                            
                            SummaryDataView
                                .padding(.bottom, 84)
                            
                            AnalysisView
                            
// MARK: - 과거
//                            HStack {
//                                Text("사용된 색상")
//                                    .font(.pretendardBold32)
//                                    .bold()
//                                    .padding(.bottom, 44)
//                                
//                                Spacer()
//                            }
//                            
//                            ScrollView(.horizontal, showsIndicators: false) {
//                                HStack(spacing: 28) {
//                                    Spacer()
//                                    
//                                    ForEach(report.colors, id: \.id) { color in
//                                        Circle()
//                                            .overlay(Circle()
//                                                .inset(by: 2)
//                                                .stroke(Color.black.opacity(0.1), lineWidth: 2)
//                                            )
//                                            .foregroundColor(Color(uiColor: color.uiColor))
//                                            .frame(width: 65, height: 65)
//                                    }
//                                    
//                                    Spacer()
//                                }
//                            }
//                            .padding(.bottom, 60)
//                            .frame(idealWidth: CGFloat(report.colors.count * 65))
//                            
//                            Divider()
//                                .padding(.bottom, 60)
//                            
//                            HStack {
//                                Text("대화 기록 보기")
//                                    .font(.pretendardBold32)
//                                    .padding(.bottom, 64)
//                                
//                                Spacer()
//                            }
//                            
//                            if !report.recordSummary.isEmpty {
//                                ForEach(0..<report.recordSummary.count) { num in
//                                    VStack(alignment: .leading) {
//                                        HStack(alignment: .top) {
//                                            Text("리붓봇")
//                                                .font(.pretendardBold24)
//                                                .fontWeight(.bold)
//                                                .foregroundColor(.primary700)
//                                                .padding(.horizontal, 12)
//                                                .padding(.vertical, 4)
//                                                .background(Color.primary300)
//                                                .cornerRadius(10)
//                                            
//                                            Text(rebootBot[num])
//                                                .font(.pretendardBold28)
//                                                .lineLimit(nil)
//                                                .multilineTextAlignment(.leading)
//                                                .lineSpacing(12)
//                                            
//                                            Spacer()
//                                        }
//                                        .padding(.bottom, 20)
//                                        Text(report.recordSummary[num]!)
//                                            .font(.pretendardMedium28)
//                                            .foregroundColor(.captionText1)
//                                            .lineSpacing(12)
//                                    }
//                                    .padding(.bottom, 52)
//                                    .frame(maxWidth: .infinity)
//                                }
//                            }
                        }
                        .padding(.horizontal, 88)
                        .padding(.vertical, 64)
                    }
                    .padding(.horizontal, 57)
                    .padding(.top, 158)
                }
                .toolbar(.hidden)
            }
        }
        .overlay(content: {
            // 실험 중
            NavigationBar(title: "\(report.name)님의 작품", subTitle: report.date, leftComponent:  {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 29)
                        .foregroundColor(.init(uiColor: UIColor(red: 0.5, green: 0.58, blue: 0, alpha: 1)))
                }
            }) {
                NavigationLink {
                    GalleryView(viewModel: viewModel)
                } label: {
                    Text("갤러리 보기")
                        .font(.pretendardSemiBold24)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(Color.primary700)
                        .cornerRadius(10)
                }
                .hideToBool(isButtonNonVisible)

            }

        })
    }
}

extension CounselingView {
    private var SummaryDataView: some View {
        ZStack {
            Color.bgPrimary300
                .cornerRadius(10)
            
            HStack {
                // 사용 문장 수
                VStack {
                    HStack {
                        Text("사용 문장 수")
                            .font(.pretendardSemiBold24)
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
                
                Divider()
                    .foregroundColor(.borderLine)
                
                // 사용 단어 수
                VStack {
                    HStack {
                        Text("사용 단어 수")
                            .font(.pretendardSemiBold24)
                            .foregroundColor(.defaultBlack)
                        
                        Spacer()
                    }
                    .padding(.leading, 36)
                    .padding(.bottom, 50)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Spacer()
                        Text("\(report.wordsCount)")
                            .font(.pretendardSemiBold40)
                            .padding(.trailing, 11)
                            .foregroundColor(.primary700)
                        
                        Text("단어")
                            .font(.pretendardMedium24)
                            .foregroundColor(.captionText1)
                            .padding(.trailing, 28)
                            .padding(.bottom, 9)
                    }
                }
                
                Divider()
                    .foregroundColor(.borderLine)
                
                // 총 작품활동 시간
                VStack {
                    HStack {
                        Text("총 작품활동 시간")
                            .font(.pretendardSemiBold24)
                            .foregroundColor(.defaultBlack)
                        
                        Spacer()
                    }
                    .padding(.leading, 36)
                    .padding(.bottom, 50)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Spacer()
                        Text("16:00")
                            .font(.pretendardSemiBold40)
                            .padding(.trailing, 36)
                            .foregroundColor(.primary700)
                    }
                }
            }
            .padding(.vertical, 24)
        }
        .frame(height: 200)
    }
    
    private var AnalysisView: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    withAnimation {
                        nowPresenting = .conversation
                    }
                } label: {
                    Text("대화 분석")
                        .font(.pretendardBold28)
                        .foregroundColor(nowPresenting == .conversation ? .defaultBlack : .unselectedText)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        nowPresenting = .color
                    }
                } label: {
                    Text("색상 분석")
                        .font(.pretendardBold28)
                        .foregroundColor(nowPresenting == .color ? .defaultBlack : .unselectedText)
                }
                
                Spacer()
            }
            .padding(.bottom, 30)
            
            Divider()
                .padding(.bottom, 56)
            
            if nowPresenting == .conversation {
                ConversationAnalysisView()
                    .transition(.opacity)
            } else {
                ColorAnalysisView(report: report)
                    .transition(.opacity)
            }
        }
    }
}

struct CounselingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CounselingView(report: ReportModel(name: "류", date: "2023-03-09", recordSummary: [1: "발보 발보 바로... 바보 ... 바롤바보..."], colors: [], imageUrl: "", firstAnswer: "넓은 마당이 있는 2층 집에 살 때, 마당에서 남편과 노을을 보며 사색을 즐겼던 순간이요."), viewModel: .init())
        }
    }
}
