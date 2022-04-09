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
    var task: URLSessionTask?
    let searchWord: String = ""
    var baseAPIUrl: String = ""
    var repositoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let detailDt = segue.destination as! DetailViewController
            detailDt.searchVC = self
        }
    }
    
}

// MARK: UITableViewDelegate,UITableViewDataSource

extension SearchViewController: UITableViewDelegate,UITableViewDataSource {
    
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
        performSegue(withIdentifier: "Detail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchWord = searchBar.text else { return }
        if searchWord.count != 0 {
            baseAPIUrl = "https://api.github.com/search/repositories?q=\(searchWord)"
            guard let changedURL = URL(string: baseAPIUrl) else { return }
            task = URLSession.shared.dataTask(with: changedURL) { (data, res, err) in
                guard let data = data else { return }
                if let obj = try! JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let items = obj["items"] as? [[String: Any]] {
                    self.repositoryList = items
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        task?.resume()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    /// 初期のテキスト削除
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
}
