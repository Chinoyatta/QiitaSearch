//
//  ArticleListViewController.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/15.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import WebKit
import RxSwift
import RxCocoa


class ArticleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles: [[String: String?]] = []
    let table = UITableView()
    let user = "Chinoyatta"
    let pageNo = "1"
    let perPage = "100"
    var webView: WKWebView!
    private let disposeBag = DisposeBag()
    
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
        
        let url = "https://qiita.com/api/v2/users/" + user + "/items?page=" + pageNo + "&per_page=" + perPage
        print(url)
        AF.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    json.forEach { (_, json) in
                        let article: [String: String?] = [
                            "title": json["title"].string,
                            "likes_count": json["likes_count"].description,
                            "userImage":json["user"]["profile_image_url"].string,
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
    
}

extension ArticleListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        guard let title = article["title"] else {
            fatalError("title nil")
        }
        guard let likes_count = article["likes_count"] else {
            fatalError("likes_count nil")
        }
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = "LGTM:" + likes_count!
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
