//
//  ImageDownloader.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class ImageDownloader {
    
    enum ImageDownloadResponse {
        case urlError
        case dataError
        case success(Data)
    }
    
    func downloadImage(repositoryData: [String : Any],completion: @escaping (ImageDownloadResponse) -> ()) {
        if let owner = repositoryData["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                guard let changedURL = URL(string: imgURL) else { completion(.urlError); return }
                URLSession.shared.dataTask(with: changedURL) { (data, res, err) in
                    guard let imageData = data else { completion(.dataError); return }
                    completion(.success(imageData))
                }.resume()
            }
        }
    }
}
