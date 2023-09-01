//
//  CounselingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct CounselingView: View {
    let report: ReportModel
    
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
                            
                            Text(report.recordSummary)
                                .font(.title2)
                        }
                        .padding(.horizontal, 88)
                        .padding(.vertical, 71)
                    }
                    .padding(.horizontal, 57)
                    .shadow(color: .black.opacity(0.1), radius: 14, x: 0, y: 10)
                }
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
    }
}

struct CounselingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CounselingView(report: .init(name: "", date: "", recordSummary: "어쩌구 저쩌구 어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저어쩌구 저쩌구 어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저어쩌구 저쩌구 어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저어쩌구 저쩌구 어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저", colors: [], imageUrl: URL(filePath: "")))
        }
    }
}
