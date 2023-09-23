//
//  Ex+ Int.swift
//  Prompt-er Seoul Secret
//
//  Created by YU WONGEUN on 2023/09/24.
//

import Foundation

extension Int {
    func secondsToTimeString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        return "\(minutesString):\(secondsString)"
    }
}

// 예시 사용 코드
//let totalSeconds = 123
//let timeString = totalSeconds.secondsToTimeString()
//print(timeString) // 출력: "02:03"
