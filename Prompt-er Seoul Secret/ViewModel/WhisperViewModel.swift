//
//  WhisperViewModel.swift
//  OpenAI
//
//  Created by YU WONGEUN on 2023/08/30.
//
//
//  WhisperViewModel.swift
//  OpenAI
//
//  Created by YU WONGEUN on 2023/08/30.
//
import Foundation
import Alamofire

final class WhisperViewModel: ObservableObject {
    private let openAIURL = "https://api.openai.com/v1/audio"
    private let apiKey = "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"
    
    func uploadAudio(fileURL: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(apiKey)"]
        
        let parameters: [String: String] = [
            "model": "whisper-1",
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
                multipartFormData.append(fileURL, withName: "file")
            },
            to: "\(openAIURL)/translations",
            headers: headers
        )
        .responseDecodable(of: TranscriptionResponse.self) {  response in
            switch response.result {
            case .success(let result):
                completion(.success(result.text))
                print(result.text)
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
    
    func uploadKoreanAudio(fileURL: URL, completion: @escaping (Result<String, Error>) -> Void) {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(apiKey)"]
        
        let parameters: [String: String] = [
            "model": "whisper-1",
            "language": "ko"
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
                }
                multipartFormData.append(fileURL, withName: "file")
            },
            to: "\(openAIURL)/transcriptions",
            headers: headers
        )
        .responseDecodable(of: TranscriptionResponse.self) {  response in
            switch response.result {
            case .success(let result):
                completion(.success(result.text))
                print(result.text)
            case .failure(let error):
                completion(.failure(error))
                print(error)
            }
        }
    }
}

struct TranscriptionResponse: Codable {
    let text: String
    
    enum CodingKeys: String, CodingKey {
        case text
    }
}
