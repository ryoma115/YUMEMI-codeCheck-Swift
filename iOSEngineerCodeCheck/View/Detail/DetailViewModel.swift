//
//  DetailViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewModel {
    
    enum DownloadResult {
        case failure
        case success(Data)
    }
    
    private let imageDownloader = ImageDownloader()
    
    func changedImage(repositoryData: [String : Any],completion: @escaping (DownloadResult) -> ()) {
        imageDownloader.downloadImage(repositoryData: repositoryData) { response in
            switch response {
            case .urlError:
                completion(.failure)
            case .dataError:
                completion(.failure)
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}
