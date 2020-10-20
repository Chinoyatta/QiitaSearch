//
//  ArticleViewController.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/18.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, WKNavigationDelegate {
    
    let webView = WKWebView()
    let articleListVC = ArticleListViewController()
    var url: String?
    var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.frame = self.view.frame
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        
        loadURL()
        
        // WebView読み込み完了時まで表示されるActivityIndicatorの表示
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .green
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        // Do any additional setup after loading the view.
    }
    
    func loadURL() {
        guard let myUrl = URL(string: url!) else {
            return
        }
        let req = URLRequest(url: myUrl)
        webView.load(req)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    // WebViewの読み込み完了時にcall
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("読み込み完了")
        activityIndicatorView.stopAnimating()
    }
    
}
