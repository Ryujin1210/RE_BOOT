//
//  CounselingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct CounselingView: View {
    let report: ReportModel
    
    @Environment(\.dismiss) var dismiss
    
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
                        VStack {
                            Text("사용된 색상")
                                .font(.pretendardBold32)
                                .bold()
                                .padding(.bottom, 27)
                            
                            HStack(spacing: 28) {
                                ForEach(report.colors, id: \.id) { color in
                                    Circle()
                                        .frame(width: 65, height: 65)
                                        .foregroundColor(Color(uiColor: color.uiColor))
                                }
                            }
                            .padding(.bottom, 72)
                            
                            Divider()
                                .padding(.bottom, 72)
                            
                            Text("대화 기록 보기")
                                .font(.pretendardBold32)
                                .padding(.bottom, 64)
                            
                            ForEach(0..<report.recordSummary.count) { num in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("리붓봇")
                                            .font(.custom("", size: 24))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("primary-700"))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 4)
                                            .background(Color("primary-300"))
                                            .cornerRadius(10)
                                        
                                        Text(rebootBot[num])
                                            .font(.pretendardBold28)
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom, 20)
                                    Text(report.recordSummary[num])
                                        .font(.pretendardMedium28)
                                        .foregroundColor(.captionText1)
                                }
                                .padding(.bottom, 52)
                            }
                        }
                        .padding(.horizontal, 88)
                        .padding(.vertical, 71)
                    }
                    .padding(.horizontal, 57)
                    .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 10)
                }
                .toolbar(.hidden)
                .navigationTitle("\(report.name)님의 작품")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        NavigationLink("갤러리 보기") {
                            GalleryView()
                        }
                    }
                }
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
                    GalleryView()
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

            }

        })
    }
}

struct CounselingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CounselingView(report: .init(name: "", date: "", recordSummary: [], colors: [], imageUrl: ""))
        }
    }
}
