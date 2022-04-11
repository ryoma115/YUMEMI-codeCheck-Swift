//
//  WebViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by N. Ryoma on 2022/04/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
// MARK: IBOutlet
    
    @IBOutlet private weak var webView: WKWebView!
    
    var repositoryUrl: String!
    private let viewModel = webViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.chagedRequest(repositoryUrl: repositoryUrl) { request in
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }

}
