//
//  ArticleViewController.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/18.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController {
    
    let webView = WKWebView()
    let articleListVC = ArticleListViewController()
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = self.view.frame
        self.view.addSubview(webView)
        
        loadURL()
        // Do any additional setup after loading the view.
    }
    
    func loadURL() {
        guard let myUrl = URL(string: url!) else {
            return
        }
        let req = URLRequest(url: myUrl)
        webView.load(req as URLRequest)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
