//
//  TagViewModel.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/02.
//

import Foundation
import Combine
import SwiftUI

class shareViewModel: ObservableObject {
    @Published var tag: Int! = 1 // 초기값 설정
    @Published var name: String = ""
    @Published var images: [UIImage] = []
    @Published var selectedImage: UIImage? = nil
    @Published var date = ""
    @Published var firstAnswer = ""
    
    init() {
        getDate()
    }
    
    func addImage(_ image: UIImage) {
        images.append(image)
    }
    
    func getDate() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYYY년 MM월 dd일"
        let today = dateFormatter.string(from: Date())
        
        date = today
    }
    
}
