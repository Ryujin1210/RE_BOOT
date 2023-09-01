//
//  CounselingView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct CounselingView: View {
    let image: UIImage
    let painterName: String
    let counselingContent: String
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 460, height: 460)
                    .shadow(color: .black.opacity(0.14), radius: 14, x: 0, y: 0)
                    .padding(.bottom, 70)
                
                Text("사용된 색상")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 27)
                
                HStack(spacing: 28) {
                    Circle()
                        .frame(width: 65, height: 65)
                    
                    Circle()
                        .frame(width: 65, height: 65)
                    
                    Circle()
                        .frame(width: 65, height: 65)
                    
                    Circle()
                        .frame(width: 65, height: 65)
                }
                .foregroundColor(Color(uiColor: UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)))
                .padding(.bottom, 63)
                
                Divider()
                    .padding(.bottom, 81)
                    .padding(.horizontal, 104)
                
                Text("대화 내용 요약")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 56)
                
                Text(counselingContent)
                    .padding(.horizontal, 104)
                    .font(.title2)
            }
            .navigationTitle("\(painterName)님의 작품")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("갤러리 보기") {
                        
                    }
                }
            }
        }
    }
}

struct CounselingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CounselingView(image: UIImage(named: "ColoringBookEx")!, painterName: "을룡태", counselingContent: "어쩌구 저쩌구 어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구어쩌구 저쩌구")
        }
    }
}
