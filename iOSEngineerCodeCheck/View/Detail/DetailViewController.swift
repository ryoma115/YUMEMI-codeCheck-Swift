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
    
    @IBOutlet private weak var repositoryImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var watchersLabel: UILabel!
    @IBOutlet private weak var forksLabel: UILabel!
    @IBOutlet private weak var issuesLabel: UILabel!
    
    var searchVC: SearchViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        
        languageLabel.text = "Written in \(specifiedRepository["language"] as? String ?? "")"
        starsLabel.text = "\(specifiedRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(specifiedRepository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(specifiedRepository["forks_count"] as? Int ?? 0) forks"
        issuesLabel.text = "\(specifiedRepository["open_issues_count"] as? Int ?? 0) open issues"
        showRepositoryImage()
        
    }
    
    func showRepositoryImage() {
        
        let specifiedRepository = searchVC.repositoryList[searchVC.repositoryIndex]
        
        titleLabel.text = specifiedRepository["full_name"] as? String
        
        if let owner = specifiedRepository["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.repositoryImageView.image = img
                    }
                }.resume()
            }
        }
        
    }
    
}
