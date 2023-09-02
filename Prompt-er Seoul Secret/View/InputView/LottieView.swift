//
//  LottieView.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/02.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    var filename: String
    
    //1. Context -> UIViewRepresentableContext<LottieView>로 수정
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: "Loading-Lottie")
        //애니메이션 크기가 적절하게 조정될 수 있도록
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        //애니메이션 재생
        animationView.play()
        
        // 컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        // 자동완성 기능
        NSLayoutConstraint.activate([
            //레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        // do nothing
    }
    
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(filename: "loading")
    }
}
