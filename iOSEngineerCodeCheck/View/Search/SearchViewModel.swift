//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewModel {
    
    enum fetchResult {
        case failure(String)
        case success
    }
    
    var dataSets: [[String: Any]] = []
    private let api = API()
    
    func fetcher(searchWord: String,completion: @escaping (fetchResult) -> ()) {
        api.fetchRepositoryData(searchWord: searchWord) { response in
            switch response {
            case .urlError:
                completion(.failure("URLの取得に失敗しました"))
            case .dataError:
                completion(.failure("データの取得に失敗しました"))
            case .success(let items):
                self.dataSets = items
                completion(.success)
            }
        }
    }
    
    func fetcherCancel() {
        api.featchCancel()
    }
}
