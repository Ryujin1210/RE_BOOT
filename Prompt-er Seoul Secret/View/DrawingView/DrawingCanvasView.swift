//
//  DrawingCanvasView.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI
import PencilKit
import UIKit

struct DrawingCanvasView: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    @Binding var isPresented: Bool
    @Binding var toolPicker: PKToolPicker
    let image: UIImage
    @State var firstTimeFlag = true
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.backgroundColor = UIColor(white: 1, alpha: 0)
        
        canvas.becomeFirstResponder()
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if isPresented && firstTimeFlag {
            setBackground()
            DispatchQueue.main.async {
                firstTimeFlag = false
            }
        }
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
    }
    
    func setBackground() {
        var imageView: UIImageView
        
        imageView = UIImageView(image: image)
        imageView.frame = canvas.frame
        print(canvas.center)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.center = canvas.center
        canvas.addSubview(imageView)
        canvas.sendSubviewToBack(imageView)
    }
}
