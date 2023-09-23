//
//  DalleViewModel.swift
//  OpenAI
//
//  Created by YU WONGEUN on 2023/08/29.
//

import Foundation
import OpenAIKit
import SwiftUI

final class openAIViewModel: ObservableObject {
    private var openai: OpenAI?
    
    func setup() {
        openai = OpenAI(Configuration(
            organizationId: "Personal",
            apiKey: "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"
        ))
    }
    
    func generateImage(prompt: String) async -> [UIImage]? {
        guard let openai = openai else {
            return nil
        }
        
        do {
            let params = ImageParameters(
                prompt: prompt,
                numberofImages: 4,
                resolution: .medium,
                responseFormat: .base64Json
            )
            
            let result = try await openai.createImage(parameters: params)
            //            let data = result.data[0].image
            //            let image = try openai.decodeBase64Image(data)
            var images: [UIImage] = []
            
            for imageData in result.data {
                let data = imageData.image
                let image = try openai.decodeBase64Image(data)
                images.append(image)
            }
            
            return images
        }
        catch {
            print(String(describing: error))
            return nil
        }
    }
    
    func getChatResponse(prompt: String) async -> String? {
        guard let openai = openai else {
            return nil
        }
        
        do {
            let chatParameters = ChatParameters(
                model: "gpt-4",
                messages: [
                    ChatMessage(role: .system, content: "You are a helpful art therapist who assists in creating scenes for drawing."),
                    ChatMessage(role: .user, content: prompt)
                ]
            )
            let completionResponse = try await openai.generateChatCompletion(
                parameters: chatParameters
            )
            let responseText = completionResponse.choices[0].message.content
            print(responseText)
            return responseText
            
        } catch {
            // 오류 처리 코드를 추가하세요.
            print(error)
            return nil
        }
    }
    
    
}
