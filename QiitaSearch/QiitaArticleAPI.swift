//
//  QiitaAPI.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/20.
//

import Foundation
import Alamofire
import SwiftyJSON

import RxSwift
import RxCocoa

protocol QiitaAPI {
    func getSearchUserArticleList(user: String) -> Single<JSON>
}

class QiitaArticleAPI: QiitaAPI {

    private let baseUrl = "https://qiita.com/api/v2/users/"

    // MARK: - Functions
    // ユーザ名を元にQiitaAPIの検索結果に紐づく記事一覧を取得する
    func getSearchUserArticleList(user: String) -> Single<JSON> {

        // APIにリクエストする際に必要なパラメーターを定義する
        let parameters: [String : Any] = [
            "page" : "1",
            "per_page" : "100",
        ]
        
        let url = baseUrl + user + "/items"

        // APIへのリクエストを1度だけ送信して結果に応じた処理をする
        return Single<JSON>.create(subscribe: { singleEvent in
            AF.request(url, method:.get, parameters: parameters).validate().responseJSON { response in
                switch response.result {
                // APIからのレスポンスの取得成功時
                case .success(let response):
                    print(url)
                    
                    let res = JSON(response)
                    print(res)
                    let json = res
                    print(json)
                    singleEvent(.success(json))

                // APIからのレスポンスの取得失敗時
                case .failure(let error):
                    singleEvent(.error(error))
                }
            }
            return Disposables.create()
        })
    }
}
