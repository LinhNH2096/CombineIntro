//
//  APIService.swift
//  CombineIntro
//
//  Created by Nguyễn Hồng Lĩnh on 21/01/2022.
//

import Foundation
import Combine

// MARK: - SingleTonge Class
final class APIService {
    
    private init () {}
    
    static var shared = APIService()
    
    // MARK: - Functions
    /// Promise of Future is used same as 'completionHandler' closure
    func fetchDummyCompanyName() -> Future<[String], Error> {
        return Future { promise in
            // Mock fetching data from API
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                // Case success
                promise(.success(["Apple", "Google", "Meta", "Amazon", "Tesla"]))
            }
            // Case failure
        }
    }
}
