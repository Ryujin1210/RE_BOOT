//
//  ContentView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = shareViewModel()
    @State private var text = ""
    @State private var currentTag: Int = 1 // 현재 태그를 저장할 변수
    @State private var previousTag: Int = 1 // 이전 태그를 저장할 변수
    
    var body: some View {
        // 애니메이션 효과를 적용할 부분
        Group {
            if currentTag == 1 {
                FirstView(viewModel: viewModel)
                    .transition(.opacity) // Crossfade 애니메이션
            } else if currentTag == 2 {
                SecondView(viewModel: viewModel, text: $text)
                    .transition(.opacity) // Crossfade 애니메이션
            } else if currentTag == 3 {
                ThirdView(viewModel: viewModel)
                    .transition(.opacity) // Crossfade 애니메이션
            } else if currentTag == 4 {
                FourthView()
                    .transition(.opacity) // Crossfade 애니메이션
            } else if currentTag == 5 {
                FifthView(viewModel: viewModel)
                    .transition(.opacity) // Crossfade 애니메이션
            } else if currentTag == 6 {
                NavigationStack {
                    DrawingView(viewModel: viewModel)
                }
                .transition(.opacity) // Crossfade 애니메이션
            } else if currentTag == 7 {
                NavigationView {
                    GalleryView()
                        .transition(.opacity)
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
                
            } else {
                EmptyView()
            }
        }
        .onAppear {
            // 화면이 나타날 때 현재 태그를 설정합니다.
            currentTag = Int(viewModel.tag)
        }
        .onChange(of: viewModel.tag) { newValue in
            // 태그가 변경될 때마다 이전 태그와 현재 태그를 업데이트하고 애니메이션을 적용합니다.
            withAnimation {
                previousTag = currentTag
                currentTag = Int(newValue!)
            }
        }
    }
}

