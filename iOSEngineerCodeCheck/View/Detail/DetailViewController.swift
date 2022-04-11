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
    
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet weak var leftStackView: UIStackView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    var webOpenButton: UIBarButtonItem!
    var searchVC = SearchViewController()
    private let viewModel = DetailViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        webOpenButton = UIBarButtonItem(title: "このリポジトリを開く", style: .done, target: self, action: #selector(openButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = webOpenButton
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        setUpText(textList: specifiedRepository)
        setUpDesign()
    }
    
    @objc func openButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Web", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController else { return }
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        viewController.repositoryUrl = specifiedRepository["html_url"] as? String
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func setUpText(textList: [String : Any]) {
        titleLabel.text = textList["full_name"] as? String ?? "タイトルなし"
        languageLabel.text = textList["language"] as? String ?? "登録なし"
        starsLabel.text = "\(textList["stargazers_count"] as? Int ?? 0)"
        watchersLabel.text = "\(textList["watchers_count"] as? Int ?? 0)"
        forksLabel.text = "\(textList["forks_count"] as? Int ?? 0)"
        issuesLabel.text = "\(textList["open_issues_count"] as? Int ?? 0)"
    }
    
    private func setUpDesign() {
        repositoryImageView.layer.cornerRadius = 10.0
        topStackView.layer.borderWidth = 1.0
        topStackView.layer.cornerRadius = 10.0
        topStackView.layer.borderColor = UIColor.black.cgColor
        leftStackView.backgroundColor = UIColor.systemGray5
        leftStackView.layer.cornerRadius = 10.0
        leftStackView.layer.borderWidth = 1.0
        leftStackView.layer.borderColor = UIColor.black.cgColor
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
