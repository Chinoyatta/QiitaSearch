//
//  ArticleListViewController.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/15.
//

import UIKit
import SwiftyJSON
import Alamofire
import WebKit


class ArticleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles: [[String: String?]] = []
    let table = UITableView()
    let user = "Chinoyatta"
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = user + "の記事"
        
        table.frame = view.frame
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        
        getArticles()
    }
    
    func getArticles() {
        
        let url = "https://qiita.com/api/v2/users/" + user + "/items"
        print(url)
        AF.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let article: [String: String?] = [
                            "title": json["title"].string,
                            "userId": json["user"]["id"].string,
                            "url":json["url"].string
                        ]
                        self.articles.append(article)
                    }
                    self.table.reloadData()
                case .failure(let error):
                    print("Error: \(String(describing: error))")
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        guard let title = article["title"] else {
            fatalError("title nil")
        }
        guard let userId = article["userId"] else {
            fatalError("usrId nil")
        }
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = userId
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let articleVC = ArticleViewController()
        guard let title = article["title"] else {
            fatalError("title nil")
        }
        guard let url = article["url"] else {
            fatalError("url nil")
        }
        articleVC.title = title
        articleVC.url = url
        self.navigationController?.pushViewController(articleVC, animated: true)
        
    }
    
}
