//
//  HighLightTest.swift
//  Prompt-er Seoul Secret
//
//  Created by YU WONGEUN on 2023/09/23.
//

import SwiftUI

struct HighLightTest: View {
    let str: String = "Hello, World! 그녀는 김치찌개를 좋아해 엄청 많이 엄청 좋아해 알지?"
    let positive: [String] = ["김치찌개를", "엄청", "Hello", "좋아"]
    let negative: [String] = ["좋아해", "그녀는", "ello", "아"]
    
    let colors: [UIColor] = [UIColor.red, UIColor.green, UIColor.blue]
       let hexColors: [String]

       init() {
           self.hexColors = convertUIColorsToHex(colors: self.colors)
       }
    
    var body: some View {
        
        // 부정 긍정
        positivehighlightedText(str: str, negativeKeyword: negative, positiveKeyword: positive)
        
        // 색상 테스트
        VStack {
                   ForEach(0..<colors.count, id: \.self) { index in
                       Text(hexColors[index])
                           .foregroundColor(Color(colors[index]))
                   }
               }
    }
}



struct HighLightTest_Previews: PreviewProvider {
    static var previews: some View {
        HighLightTest()
    }
}

