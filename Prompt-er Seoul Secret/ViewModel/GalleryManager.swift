//
//  GalleryManager.swift
//  Prompt-er Seoul Secret
//
//  Created by 정승균 on 2023/08/31.
//

import Foundation

class GalleryManager: ObservableObject {
    @Published var reports: [ReportModel] = []
    
    init() {
        getReports()
    }
    
    func getReports() {
        let userDirectoryUrl = try? getUsersDirectory()
        
        let dirs = try! FileManager.default.contentsOfDirectory(at: userDirectoryUrl!, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
        
        print(dirs)
        
        var returnReports: [ReportModel] = []
        
        for dir in dirs {
            let jsonData: Data
            
            let jsonUrl = dir.appendingPathComponent("data.json")
            
            do {
                jsonData = try Data(contentsOf: jsonUrl)
                
                let decoder = JSONDecoder()
                returnReports.append(try decoder.decode(ReportModel.self, from: jsonData))
                
            } catch {
                print("parsing error \(error)")
            }
        }
        
        self.reports = returnReports
        print(self.reports)
    }
    
    private func getUsersDirectory() throws -> URL {
        // 루트 디렉토리 찾기
        let rootDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // 저장 디렉토리 설정
        guard let toSaveDirectory = rootDirectory?.appendingPathComponent("users") else {
            throw SaveError.generateUrlError
        }
        
        return toSaveDirectory
    }
}
