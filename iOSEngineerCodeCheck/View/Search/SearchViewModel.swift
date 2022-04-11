//
//  SearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewModel {
    
    enum featchRepositoryResponse {
        case urlError
        case dataError
        case success
    }
    
    var dataSets: [[String: Any]] = []
    var task: URLSessionTask?
    let searchWord: String = ""
    var baseAPIUrl: String = ""
    
    func featchRepositoryData(searchWord: String,completion: @escaping (featchRepositoryResponse) -> ()) {
        baseAPIUrl = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let changedURL = URL(string: baseAPIUrl) else { completion(.urlError); return }
        task = URLSession.shared.dataTask(with: changedURL) { (data, res, err) in
            guard let data = data else { completion(.dataError); return }
            if let obj = try! JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let items = obj["items"] as? [[String: Any]] {
                    self.dataSets = items
                    completion(.success)
                }
            }
        }
        task?.resume()
    }
    
    func fetchCancel() {
        task?.cancel()
    }
}
