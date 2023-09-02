//
//  ReportModel.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/09/01.
//

import UIKit

struct ReportModel: Codable, Identifiable {
    let name: String
    let date: String
    let recordSummary: String
    let colors: [CustomColor]
    let imageUrl: String

    var id: String {
        name + date
    }
    
    var uiImage: UIImage {
        let path: String = imageUrl
        print("========>>>>\(path)")
        guard let image = UIImage(contentsOfFile: path) else {
            print("에러남?")
            return UIImage(named: "ColoringBookEx") ?? UIImage()
        }
        
        return image
    }
}

struct CustomColor : Codable, Identifiable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
    var id: String {
        "\(red)\(green)\(blue)\(alpha)"
    }
    
    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}
