//
//  FifthView.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/02.
//

import SwiftUI

struct FifthView: View {
    @StateObject var viewModel: shareViewModel
    @State var images: [UIImage] = []
    @State private var selectedImage: UIImage? = nil
    @State private var isButtonEnabled = false 
    
    var body: some View {
        VStack {
            Text("밑그림 선택하기")
                .font(.pretendardBold40)
                .foregroundColor(.primary900)
                .padding(.horizontal, 56)
                .padding(.vertical, 12)
                .background(Color.primary300.opacity(0.3))
                .cornerRadius(10)
            Text("마음에 드는 밑그림을 선택한 후\n'색칠하러 가기' 버튼을 눌러주세요")
                .font(.pretendardBold32)
                .multilineTextAlignment(.center)
                .padding(.top, 24)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: images.count), spacing: 48) {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 235, height: 235)
                        .onTapGesture {
                            // 이미지를 탭하면 선택된 이미지를 변경
                            if selectedImage == image {
                                selectedImage = nil // 이미 선택된 이미지를 다시 탭하면 선택이 해제됩니다.
                            } else {
                                selectedImage = image // 이미지를 탭하면 선택됩니다.
                            }
                        }
                        .cornerRadius(10)
                        .shadow(color: selectedImage == image ? Color.primary500 : Color.clear, radius: 8, x: 0, y: 0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .inset(by: selectedImage == image ? -4 : 0.5)
                                .stroke(selectedImage == image ? Color.primary500 : Color.black,
                                        lineWidth: selectedImage == image ? 8 : 1)
                        )}
            }
            .onAppear {
                images = viewModel.images
            }
            .padding(.top, 70)
            
            Button(action: {
                viewModel.selectedImage = self.selectedImage
                print(viewModel.selectedImage!.size)
                viewModel.tag = 6
            }) {
                Text("색칠하러 가기")
                    .font(.pretendardBold40)
                    .frame(width: 612 , height: 128)
                    .background(selectedImage != nil ? Color.primary700 : Color.primary300.opacity(0.3))
                    .cornerRadius(20)
                    .foregroundColor(selectedImage != nil ? .white : .disableText)
            }
            .disabled(selectedImage == nil)
            .padding(.top, 70)
        }
    }
}

