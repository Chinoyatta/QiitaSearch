//
//  ArticleListViewModel.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/20.
//

import Foundation
import SwiftyJSON

import RxSwift
import RxCocoa

class ArticleListViewModel {
    
    private let qiitaAPI: QiitaAPI!
    private let disposeBag = DisposeBag()
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let articleLists = BehaviorRelay<[ArticleListModel]>(value: [])
    
    init(api: QiitaAPI) {
        qiitaAPI = api
    }
    
    func getArticles(user: String) {
        
        // ニュース記事のデータを取得する処理を実行する
        qiitaAPI.getSearchUserArticleList(user: user).subscribe(
            
            // JSON取得が成功した場合の処理
            onSuccess: { json in
                let articleList = self.getSearchNewsModelListsBy(json: json)
                print(articleList)
                self.executeSuccessResponseAction(articleList: articleList)
            },
            
            // JSON取得が失敗した場合の処理
            onError: { error in
                print("Error: ", error.localizedDescription)
            }
            
        ).disposed(by: disposeBag)
    }
    
    private func executeSuccessResponseAction(articleList: [ArticleListModel]) {
        articleLists.accept(articleList)
        isLoading.accept(false)
    }
    // レスポンスで受け取ったJSONから表示に必要なものを詰め直す
    private func getSearchNewsModelListsBy(json: JSON) -> [ArticleListModel] {
        return json.map{ ArticleListModel(json: $0.1) }
    }
}
