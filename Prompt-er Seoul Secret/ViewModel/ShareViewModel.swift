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
    
    func addImage(_ image: UIImage) {
        images.append(image)
    }
    
}
