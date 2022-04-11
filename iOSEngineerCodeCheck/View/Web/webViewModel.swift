//
//  webViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class webViewModel {
    
    func chagedRequest(repositoryUrl: String,completion: @escaping (URLRequest) -> ()) {
        guard let url = URL(string: repositoryUrl) else { return }
        let request = URLRequest(url: url)
        completion(request)
    }
    
}
