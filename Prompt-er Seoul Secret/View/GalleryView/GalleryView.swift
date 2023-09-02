//
//  GalleryView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/01.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var galleryManager = GalleryManager()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(galleryManager.reports, id: \.id) { report in
                        NavigationLink {
                            CounselingView(report: report)
                        } label: {
                            ThumbnailView(report: report)
                        }
                    }
                }
            }
            .padding(.top, 70)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color("background"))
        .toolbar(.hidden)
        .overlay(content: {
            NavigationBar(title: "갤러리", leftComponent:  {
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
