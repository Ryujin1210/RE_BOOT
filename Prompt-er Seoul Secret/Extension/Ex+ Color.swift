//
//  ColorExtension.swift
//  Secret
//
//  Created by YU WONGEUN on 2023/09/01.
//

import Foundation
import SwiftUI

extension Color {
    // MARK: - 사용 법 to 규니 ... static let 변수명 = Color(hex: 원하는 헥스코드)
//    static let btnGreen = Color.init(hex: "A5B15F")
//    static let primaryShadow = Color.primary.opacity(0.2)
//    static let secondaryText = Color(hex: "#6e6e6e") // ~
//    static let primary_300 = Color(hex: "7F9500")
//    static let primary_300_opacity = Color(hex: "A5B15F").opacity(0.3)
//    static let btnRed = Color.init(hex: "B66644")
//    static let primary_900 = Color(hex: "#627300")
//    static let primary_500 = Color(hex: "A5B15F")
    
    // Primary
    static let primary300 = Color("primary-300")
    static let primary500 = Color("primary-500")
    static let primary700 = Color("primary-700")
    static let primary900 = Color("primary-900")
    static let btnRed = Color("btnRed")
    // Background
    static let bgPrimary300 = Color("bg-primary-300")
    static let bgColoring = Color("bg-coloring")
    static let greenhi = Color("green-hi")
    static let redhi = Color("red-hi")
    // TextColor
    static let captionText1 = Color("caption-text1")
    static let captionText2 = Color("caption-text1")
    static let defaultBlack = Color("default-black")
    static let disableText = Color("disable-text")
    static let bodyText = Color("body-text")
    static let unselectedText = Color("unselected-text")
    
    // Border Line
    static let borderLine = Color("borderLine")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)  // 문자열 파서 역할을 하는 클래스
        _ = scanner.scanString("#") // scanString은 iOS 13부터 지원. "#" 문자 제거
        
        var rgb: UInt64 = 0
        // 문자열을 Int64 타입으로 변환해 rgb 변수에 저장. 변환할 수 없다면 0 을 반환
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0  // 좌측 문자열 2개 추출
        let g = Double((rgb >> 8) & 0xFF) / 255.0 // 중간 문자열 2개 추출
        let b = Double((rgb >> 0) & 0xFF) / 255.0 // 우측 문자열 2개 추출
        self.init(red: r, green: g, blue: b)
    }
}

extension UIColor {
    func toHex() -> String {
        guard let components = self.cgColor.components else {
            return "#000000" // 기본값 (검정색)
        }
        
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}

// 색상 -> hex 변환 소스
func convertUIColorsToHex(colors: [UIColor]) -> [String] {
    return colors.map { $0.toHex() }
}


