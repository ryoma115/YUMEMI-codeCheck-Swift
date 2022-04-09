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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        setUpText(textList: specifiedRepository)
    }
    
// MARK: IBAction
    
    @IBAction func tapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpText(textList: [String : Any]) {
        titleLabel.text = textList["full_name"] as? String ?? "タイトルなし"
        languageLabel.text = "Written in \(textList["language"] as? String ?? "")"
        starsLabel.text = "\(textList["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(textList["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(textList["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(textList["open_issues_count"] as? Int ?? 0) open issues"
    }
    
    private func showRepositoryImage() {
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        
        if let owner = specifiedRepository["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                guard let changedURL = URL(string: imgURL) else { return }
                URLSession.shared.dataTask(with: changedURL) { (data, res, err) in
                    guard let data = data else { return }
                    guard let dataImage = UIImage(data: data) else { return }
                    DispatchQueue.main.async {
                        self.repositoryImageView.image = dataImage
                    }
                }.resume()
            }
        }
    }
    
}
