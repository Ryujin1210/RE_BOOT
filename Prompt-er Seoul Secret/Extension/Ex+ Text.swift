//
//  Ex+ Text.swift
//  Prompt-er Seoul Secret
//
//  Created by YU WONGEUN on 2023/09/23.
//

import Foundation
import SwiftUI

// MARK: - function
func positivehighlightedText(str: String, negativeKeyword: [String] , positiveKeyword: [String]) -> Text {
    // 빈 문자열 또는 검색어 배열이 비어있을 경우 원래 문자열 그대로 반환
    guard !str.isEmpty else { return Text(str) }
    
    // 결과 Text를 저장할 변수 초기화
    var result: Text = Text("")
    
    // 문자열을 공백을 기준으로 분할
    let words = str.components(separatedBy: " ")
    
    for word in words {
        // 단어가 검색어 배열에 포함되는 경우 강조 처리하여 결과에 추가
        if positiveKeyword.contains(word) {
            result = result
                .font(.pretendardMedium24)
                .foregroundColor(.bodyText)
            + Text(word)
                .font(.pretendardBold24)
                .foregroundColor(.primary700)
            
        } else if negativeKeyword.contains(word) {
            result = result
                .font(.pretendardMedium24)
                .foregroundColor(.bodyText)
            + Text(word)
                .font(.pretendardBold24)
                .foregroundColor(.btnRed)
        }
        else {
            // 그 외의 경우 단어를 그대로 결과에 추가
            result = result + Text(word)
                .font(.pretendardMedium24)
                .foregroundColor(.bodyText)
        }
        
        // 단어 사이에 공백 추가 (원래 문자열의 공백을 유지)
        result = result + Text(" ")
    }
    
    return result
}



func negativehighlightedText(str: String, searched: [String]) -> Text {
    // 빈 문자열 또는 검색어 배열이 비어있을 경우 원래 문자열 그대로 반환
    guard !str.isEmpty && !searched.isEmpty else { return Text(str) }
    
    // 결과 Text를 저장할 변수 초기화
    var result: Text = Text("")
    
    // 문자열을 공백을 기준으로 분할
    let words = str.components(separatedBy: " ")
    
    for word in words {
        // 단어가 검색어 배열에 포함되는 경우 강조 처리하여 결과에 추가
        if searched.contains(word) {
            result = result + Text(word)
                .foregroundColor(.red)
                .bold()
        } else {
            // 그 외의 경우 단어를 그대로 결과에 추가
            result = result + Text(word)
        }
        
        // 단어 사이에 공백 추가 (원래 문자열의 공백을 유지)
        result = result + Text(" ")
    }
    
    return result
}
