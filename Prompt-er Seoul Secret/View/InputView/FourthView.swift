//
//  FourthView.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/02.
//

import SwiftUI
import Lottie

struct FourthView: View {
    var body: some View {
        VStack {
            LottieView(filename: "loading")
                .frame(width: 550, height: 520)
            Text("밑그림 이미지를 생성 중이에요 \n 잠시만 기다려주세요")
                .font(.pretendardBold36)
                .multilineTextAlignment(.center)
        }
        
    }
}

struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}
