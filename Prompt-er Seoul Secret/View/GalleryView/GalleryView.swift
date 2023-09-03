//
//  GalleryView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/01.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var galleryManager = GalleryManager()
    @StateObject var viewModel: shareViewModel
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            
//            Text("작품을 선택하면\n추가적인 내용을 확인할 수 있어요.")
//                .font(.pretendardBold28)
//                .foregroundColor(.primary900)
//                .multilineTextAlignment(.center)
//                .padding(.bottom, 53)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(galleryManager.reports, id: \.id) { report in
                        NavigationLink {
                            CounselingView(report: report, isButtonNonVisible: true, viewModel: viewModel)
                        } label: {
                            ThumbnailView(report: report)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 48)
        }
        .background(Color("background"))
        .toolbar(.hidden)
        .overlay(content: {
            NavigationBar(title: "갤러리", leftComponent:  {
                Button {
                    viewModel.tag = 1
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 29)
                        .foregroundColor(.init(uiColor: UIColor(red: 0.5, green: 0.58, blue: 0, alpha: 1)))
                }
            }) {
                EmptyView()
            }
        })
        
    }
}
//
//struct GalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            GalleryView()
//        }
//    }
//}
