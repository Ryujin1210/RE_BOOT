//
//  GalleryView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/01.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var galleryManager = GalleryManager()
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 64) {
                    ForEach(galleryManager.reports, id: \.id) { report in
                        NavigationLink {
                            CounselingView(report: report)
                        } label: {
                            ThumbnailView(report: report)
                        }
                    }
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .navigationTitle("갤러리")
        .navigationBarTitleDisplayMode(.large)
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
