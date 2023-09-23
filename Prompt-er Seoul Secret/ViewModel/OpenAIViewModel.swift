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
    static let shared = openAIViewModel()
    
    private var openai: OpenAI?
    
    func setup() {
        openai = OpenAI(Configuration(
            organizationId: "Personal",
            apiKey: "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"
        ))
    }
    //MARK: - 이미지 생성 요청
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
    
    //MARK: - 그림을 그리기 위해 요약 편집 요청
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
    
    //MARK: - 대화 전문 요약 요청
    func getSummarizeChatResponse(prompt: String) async -> String? {
        guard let openai = openai else {
            return nil
        }
        var sumPrompt = prompt + "\n" + "Can you summarize this sentence into one paragraph for art therapy analysis?\nAnswer to Korean"
        do {
            let chatParameters = ChatParameters(
                model: "gpt-4",
                messages: [
                    ChatMessage(role: .system, content: "you are a helpful summarize assistant for summarizing"),
                    ChatMessage(role: .user, content: sumPrompt)
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
    
    //MARK: - 색채 분석을 위한 요청
    func getColorChatResponse(firstAnswer: String, colors: [UIColor]) async -> String? {
        guard let openai = openai else {
            return nil
        }
        
        let mostColors = convertUIColorsToHex(colors: colors)
        //        let sumPrompt = "we used" + "\(mostColors)" + "and this drawing is about" + "\(firstAnswer)" + "Can you summarize this sentence into one paragraph for art therapy analysis?, Answer to Korean"
        //        let sumPrompt = "provide a one-paragraph summary in Korean interpreting" + "\(mostColors)" + "used and the title is" + "\(firstAnswer)"
        let sumPrompt = "can you analyze in one paragraph based on the " + "\(mostColors)" + " used for this \(firstAnswer)  ,and Translate the sentence into Korean for a response."
        do {
            let chatParameters = ChatParameters(
                model: "gpt-4",
                messages: [
                    ChatMessage(role: .system, content: "You are a professional art therapist who assists for senior counseling."),
                    ChatMessage(role: .user, content: sumPrompt)
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
    
    //MARK: - 구문점 과 마침표를 위한 문장 편집기
    func getEditorChatResponse(prompt: String) async -> String? {
        guard let openai = openai else {
            print("openai")
            return nil
        }
        let editorPrompt = prompt + "\n" + "Can you insert periods and punctuation marks appropriately in this text? if i provide already contains appropriate puctuation and periods just return"
        
        do {
            let chatParameters = ChatParameters(
                model: "gpt-4",
                messages: [
                    ChatMessage(role: .system, content: "You are a professional sentence editor"),
                    ChatMessage(role: .user, content: editorPrompt)
                ]
            )
            let completionResponse = try await openai.generateChatCompletion(
                parameters: chatParameters
            )
            let responseText = completionResponse.choices[0].message.content
            print("마침표 편집문 : " + responseText)
            return responseText
            
        } catch {
            // 오류 처리 코드를 추가하세요.
            print("DEBUG: " + error.localizedDescription)
            return nil
        }
    }
    
    //MARK: - Json 긍정 부정
    func getJsonChatResponse(prompt: String) async -> String? {
        guard let openai = openai else {
            print("openai")
            return nil
        }
        let editorPrompt = "show me the count, list of words of positive/negative words in JSON format, in" + "\(prompt)"
        
        do {
            let chatParameters = ChatParameters(
                model: "gpt-4",
                messages: [
                    ChatMessage(role: .system, content: " You are a helpful JSON edito, You can respone only my JSON Format template without other sentence, Template : { \"positive\": { \"count\": Int, \"words\": [String] }, \"negative\": { \"count\": Int, \"words\": [String] }}") ,
                    ChatMessage(role: .user, content: editorPrompt)
                ]
            )
            let completionResponse = try await openai.generateChatCompletion(
                parameters: chatParameters
            )
            let responseText = completionResponse.choices[0].message.content
            print("마침표 편집문 : " + responseText)
            return responseText
            
        } catch {
            // 오류 처리 코드를 추가하세요.
            print("DEBUG: " + error.localizedDescription)
            return nil
        }
    }
    
    
}
