//
//  ThumbnailView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/01.
//

import SwiftUI

struct ThumbnailView: View {
    let report: ReportModel
    
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.14), radius: 16.8, x: 0, y: 4.8)
            VStack(spacing: 0) {
                Image(uiImage: report.uiImage)
                    .resizable()
                    .frame(width: 400, height: 400)
                    .scaledToFill()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(report.name)씨의 작품")
                            .padding(.top, 30)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                    
                    Text("\(report.date)")
                        .foregroundColor(.black.opacity(0.3))
                        .padding(.leading, 10)
                        .padding(.bottom, 30)
                }
                .frame(width: 400)
                .cornerRadius(10)
            }
        }
        .frame(width: 400, height: 450)
        .padding(.horizontal, 64)
        .padding(.vertical, 80)
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(report: .init(name: "", date: "", recordSummary: [], colors: [], imageUrl: ""))
            .previewLayout(.sizeThatFits)
    }
}
