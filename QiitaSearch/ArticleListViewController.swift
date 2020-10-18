//
//  ArticleListViewController.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/15.
//

import UIKit
import SwiftyJSON
import Alamofire


class ArticleListViewController: UIViewController, UITableViewDataSource {
    
    var articles: [[String: String?]] = []
    let table = UITableView()
    let aaa = "Chinoyatta"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = aaa + "の記事"
        
        table.frame = view.frame
        view.addSubview(table)
        table.dataSource = self
        
        getArticles()
    }
    
    func getArticles() {
        
        let url = "https://qiita.com/api/v2/users/" + aaa + "/items"
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
                            "url":json["user"].string
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
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userId"]!
        return cell
    }
    
}
