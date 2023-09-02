//
//  CustomNavigationBar.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/02.
//

import SwiftUI

struct NavigationBar<L, R>: View where L: View, R: View {
    var title = ""
    var subTitle = ""
    
    let leftComponent: (() -> L)?
    let rightComponent: (() -> R)?
    
    init(title: String = "", subTitle: String = "", leftComponent: (() -> L)? = nil, rightComponent: (() -> R)? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.leftComponent = leftComponent
        self.rightComponent = rightComponent
    }
    
    var body: some View {
        ZStack {
            Color.clear
//                .foregroundStyle(.ultraThinMaterial)
                .background(.ultraThinMaterial)
//                .blur(radius: 10)
                .ignoresSafeArea(.all, edges: .top)
            ZStack {
                HStack {
                    leftComponent?()
                    
                    Spacer()
                    
                    rightComponent?()
                }
                .padding(.horizontal, 36)
             
                
                Spacer()
                
                VStack(spacing: 0) {
                    Text(title)
                        .font(.pretendardSemiBold30)
                    
                    if subTitle != "" {
                        Text(subTitle)
                            .font(.pretendardMedium16)
                            .foregroundColor(.captionText1)
                    }
                }
                
                Spacer()
                
            }
        }
        .frame(height: 102)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct NavigationBar_Preview: PreviewProvider {
    static var previews: some View {
        NavigationBar(title: "hello", subTitle: "무어요") {
            Text("hello")
        } rightComponent: {
            Text("Hello")
        }
    }
}

//struct CustomNavigationBar<C, L, R>: ViewModifier where C: View, L: View, R: View {
//
//    let centerView: (() -> C)?
//    let leftView: (() -> L)?
//    let rightView: (() -> R)?
//
//    init(centerView: (() -> C)? = nil, leftView: (() -> L)? = nil, rightView: (() -> R)? = nil) {
//        self.centerView = centerView
//        self.leftView = leftView
//        self.rightView = rightView
//    }
//
//    func body(content: Content) -> some View {
//        VStack {
//            ZStack {
//                HStack {
//                    self.leftView?()
//
//                    Spacer()
//
//                    self.rightView?()
//                }
//                .frame(height: 44)
//                .frame(maxWidth: .infinity)
//                .padding(.horizontal, 16)
//
//                HStack {
//                    Spacer()
//
//                    self.centerView?()
//
//                    Spacer()
//                }
//            }
//            .background(Color(.white).ignoresSafeArea(.all, edges: .top))
//
//            Spacer()
//
//            content
//
//            Spacer()
//        }
//        .toolbar(.hidden)
//    }
//}
//
//struct CustomNavigationBar_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            Text("Hello, world!")
//        }
//        .modifier(CustomNavigationBar<Text, Text, Text>(centerView: {
//                Text("Heelo")
//            }))
//    }
//}
//
//extension View {
//
//}
