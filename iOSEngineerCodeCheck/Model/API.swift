//
//  API.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class API {
    
    enum fetchRepositoryResponse {
        case urlError
        case dataError
        case success([[String: Any]])
    }
    
    var task: URLSessionTask?
    var baseAPIUrl: String = ""
    
    func fetchRepositoryData(searchWord: String,completion: @escaping (fetchRepositoryResponse) -> ()) {
        baseAPIUrl = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let changedURL = URL(string: baseAPIUrl) else { completion(.urlError); return }
        task = URLSession.shared.dataTask(with: changedURL) { (data, res, err) in
            guard let data = data else { completion(.dataError); return }
            if let obj = try! JSONSerialization.jsonObject(with: data) as? [String: Any] {
                if let items = obj["items"] as? [[String: Any]] {
                    completion(.success(items))
                }
            }
        }
        task?.resume()
    }
    
    func featchCancel() {
        task?.cancel()
    }
}
