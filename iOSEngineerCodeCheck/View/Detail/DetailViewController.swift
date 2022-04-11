//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var repositoryImageView: UIImageView! {
        didSet {
            showRepositoryImage()
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    var searchVC = SearchViewController()
    private let viewModel = DetailViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        setUpText(textList: specifiedRepository)
    }
    
    private func setUpText(textList: [String : Any]) {
        titleLabel.text = textList["full_name"] as? String ?? "タイトルなし"
        languageLabel.text = "Written in \(textList["language"] as? String ?? "")"
        starsLabel.text = "\(textList["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(textList["watchers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(textList["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(textList["open_issues_count"] as? Int ?? 0) open issues"
    }
    
    private func showRepositoryImage() {
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        viewModel.changedImage(repositoryData: specifiedRepository) { imageData in
            guard let imageView = UIImage(data: imageData) else { return }
            DispatchQueue.main.async {
                self.repositoryImageView.image = imageView
            }
        }
    }
}
