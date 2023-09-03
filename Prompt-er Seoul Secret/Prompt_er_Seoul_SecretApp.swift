//
//  Prompt_er_Seoul_SecretApp.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import SwiftUI

@main
struct Prompt_er_Seoul_SecretApp: App {
    @StateObject var drawingManager = DrawingManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(drawingManager)
            
//            DrawingView(viewModel: shareViewModel())
        }
    }
}
