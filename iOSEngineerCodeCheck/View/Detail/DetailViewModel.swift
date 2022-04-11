//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewModel {
    
    func changedImage(repositoryData: [String : Any],completion: @escaping (Data) -> ()) {
        if let owner = repositoryData["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                guard let changedURL = URL(string: imgURL) else { return }
                URLSession.shared.dataTask(with: changedURL) { (data, res, err) in
                    guard let imageData = data else { return }
                    completion(imageData)
                }.resume()
            }
        }
    }
}
