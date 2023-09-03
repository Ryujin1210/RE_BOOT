//
//  CounselingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct CounselingView: View {
    let report: ReportModel
    var isButtonNonVisible = false
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: shareViewModel
    
    let rebootBot: [String] = [
        "안녕하세요! 이제 자유롭게 색칠을 해볼까요? 먼저 원하는 색을 골라보세요!",
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
                    Image(uiImage: report.uiImage)
                        .resizable()
                        .frame(width: 460, height: 460)
                        .shadow(color: .black.opacity(0.14), radius: 14, x: 0, y: 0)
                        .padding(.bottom, 70)
                        .padding(.top, 158)
                    
                    ZStack {
                        Color.white
                            .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 10)
                        VStack {
                            HStack {
                                Text("사용된 색상")
                                    .font(.pretendardBold32)
                                    .bold()
                                    .padding(.bottom, 27)
                                
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 28) {
                                    Spacer()
                                    
                                    ForEach(report.colors, id: \.id) { color in
                                        Circle()
                                            .overlay(Circle()
                                                .inset(by: 2)
                                                .stroke(Color.black.opacity(0.1), lineWidth: 2)
                                            )
                                            .foregroundColor(Color(uiColor: color.uiColor))
                                            .frame(width: 65, height: 65)
                                    }
                                    
                                    Spacer()
                                }
                            }
                            .padding(.bottom, 72)
                            .frame(idealWidth: CGFloat(report.colors.count * 65))
                            
                            Divider()
                                .padding(.bottom, 72)
                            
                            HStack {
                                Text("대화 기록 보기")
                                    .font(.pretendardBold32)
                                    .padding(.bottom, 64)
                                
                                Spacer()
                            }
                            
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
                        .padding(.horizontal, 88)
                        .padding(.vertical, 71)
                    }
                    .padding(.horizontal, 57)
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
//
//struct CounselingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            CounselingView(report: .init(name: "", date: "", recordSummary: [:], colors: [], imageUrl: ""))
//        }
//    }
//}
