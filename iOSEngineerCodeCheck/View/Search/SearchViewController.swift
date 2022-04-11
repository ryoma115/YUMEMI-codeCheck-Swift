//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

// MARK: IBOutlet
        
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet{
            searchBar.text = "GitHubのリポジトリを検索できるよ"
            searchBar.delegate = self
        }
    }
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    var repositoryList: [[String: Any]] = []
    var repositoryIndex: Int = 0
    
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: UITableViewDelegate,UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
        let assignedRepository = repositoryList[indexPath.row]
        cell.textLabel?.text = assignedRepository["full_name"] as? String
        cell.detailTextLabel?.text = assignedRepository["language"] as? String
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    /// 画面遷移ポイント
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repositoryIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        viewController.searchVC = self
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text else { return }
        if searchWord.count != 0 {
            viewModel.featchRepositoryData(searchWord: searchWord) { response in
                switch response {
                case .urlError:
                    searchBar.text = "URLの取得に失敗しました"
                case .dataError:
                    searchBar.text = "データの取得に失敗しました"
                case .success:
                    self.repositoryList = self.viewModel.dataSets
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.fetchCancel()
    }
    
    /// 初期のテキスト削除
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
}
