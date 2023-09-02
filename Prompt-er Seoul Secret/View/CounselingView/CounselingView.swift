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
                        .padding(.top, 56)
                    
                    ZStack {
                        Color.white
                        VStack {
                            Text("사용된 색상")
                                .font(.title)
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
                            
                            Text("대화 내용 요약")
                                .font(.title)
                                .bold()
                                .padding(.bottom, 64)
                            
                            Text("report.recordSummary.count")
                                .font(.title2)
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
                        .font(.custom("SF Pro", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                        .background(Color("primary-700"))
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
