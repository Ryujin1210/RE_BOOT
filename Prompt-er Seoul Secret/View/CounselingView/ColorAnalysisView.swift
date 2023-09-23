//
//  ColorAnalysisView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/23.
//

import SwiftUI

struct ColorAnalysisView: View {
    let report: ReportModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("사용된 색상 분석")
                    .font(.pretendardBold32)
                    .bold()
                
                Spacer()
            }
            .padding(.bottom, 48)
            
            HStack(spacing: 0) {
                Text("\(report.name)")
                    .font(.pretendardBold28)
                
                Text("님은")
                    .font(.pretendardSemiBold28)
                
                Spacer()
            }
            .padding(.bottom, 20)
            
            HStack(alignment: .bottom, spacing: 8) {
                Text("총")
                    .font(.pretendardSemiBold28)
                    .padding(.bottom, 6)
                
                Text("\(report.colors.count)가지")
                    .font(.pretendardBold44)
                    .foregroundColor(.primary700)
                
                Text("색상을 사용하셨어요.")
                    .font(.pretendardSemiBold28)
                    .padding(.bottom, 6)
            }
            .padding(.bottom, 48)
            
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
            
            
            HStack {
                Text("주로 사용하신 색상")
                    .font(.pretendardBold28)
                    .bold()
                
                Spacer()
            }
            
            // 주로 사용한 색상 프로퍼티 추가
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
            .padding(.bottom, 72)
            
            Divider()
                .padding(.bottom, 48)
            
            HStack {
                Text("색상 분석 요약")
                    .font(.pretendardBold28)
                    .bold()
                
                Spacer()
            }
            .padding(.bottom, 24)
            
            HStack {
                Text("선명한 색상을 선택하여 그림의 색채가 아주 명료합니다. 연두색과 불빛(빨강, 파랑, 노랑) 등으로 인해 어둡지 않습니다. 때문에 연두색의 싱그러움, 봄(시작)의 설렘, 자연의 편안함, 검정색의 불안감 등 다양한 감정이 동시에 느껴지는 그림입니다.")
                    .font(.pretendardMedium24)
                    .foregroundColor(.bodyText)
                
                Spacer()
            }
        }
    }
}
//
//#Preview {
//    ColorAnalysisView(report: ReportModel(name: "류", date: "2023-03-09", recordSummary: [1: "발보 발보 바로... 바보 ... 바롤바보..."], colors: [], imageUrl: "", firstAnswer: "넓은 마당이 있는 2층 집에 살 때, 마당에서 남편과 노을을 보며 사색을 즐겼던 순간이요."))
//}
