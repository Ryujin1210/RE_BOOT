//
//  SecondView.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/02.
//

import SwiftUI

struct SecondView: View {
    @StateObject var viewModel: shareViewModel
    @Binding var text: String
    @State private var isNameEntered = false // 이름이 입력되었는지 추적하는 상태 변수
    var body: some View {
        NavigationView { // 내용을 NavigationView로 감쌉니다.
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1002, height: 720)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.1),
                            radius: 14, x: 0, y: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.1), lineWidth: 1)
                    )
                    .padding(.top, 114)
                
                VStack(alignment: .center) {
                    VStack {
                        Text("안녕하세요")
                            .font(.pretendardBold40)
                            .multilineTextAlignment(.center)
                        Text("작품을 만들기 전,")
                            .font(.pretendardBold40)
                            .multilineTextAlignment(.center)
                        HStack {
                            
                            Text("어르신의 성함을 ")
                                .font(.pretendardBold40)
                                .foregroundColor(Color.primary700) // 초록색 적용
                            
                            Text("알려주세요!")
                                .font(.pretendardBold40)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(100)
                    
                    TextField("성함을 입력해주세요", text: $text)
                        .multilineTextAlignment(.center) // 텍스트를 가운데로 정렬
                        .font(.pretendardBold40)
                        .frame(width: 485.5, height: 89)
                        .onChange(of: text) { newValue in
                            // TextField의 값이 변경될 때마다 호출되는 클로저
                            isNameEntered = !newValue.isEmpty // 입력값이 비어 있지 않으면 버튼 활성화
                        }
                    
                    Rectangle()
                        .frame(width: 485.5, height: 3) // 사각형의 크기 설정
                        .foregroundColor(Color.primary700) // 사각형의 색상 설정
                    
                    Button(action: {
                        viewModel.tag = 3
                        viewModel.name = text
                        text = ""
                    }) {
                        Text("이름 입력 완료")
                            .font(.pretendardBold40)
                            .frame(width: 612, height: 128, alignment: .center)
                            .background(isNameEntered ? Color.primary500 : Color.primary300.opacity(0.3)) // 이름이 입력되었을 때와 그렇지 않을 때 배경색 설정
                            .cornerRadius(20)
                            .foregroundColor(isNameEntered ? .white : .disableText)
                    }
                    .padding(.top, 80)
                    .disabled(!isNameEntered) // 이름이 입력되지 않으면 버튼 비활성화
                    
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationBarTitle("", displayMode: .inline) // 네비게이션 제목을 지웁니다.
            .navigationBarBackButtonHidden(true) // 기본
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.tag = 1
                    }) {
                        Image(systemName: "chevron.backward")
                            .font(.title)
                            .foregroundColor(.primary700)
                    }
                }
            }
            
        }
        .navigationViewStyle(.stack)

    }
    
}
