//
//  ArticleListModel.swift
//  QiitaSearch
//
//  Created by 千野栄一 on 2020/10/20.
//

import Foundation
import SwiftyJSON

struct ArticleListModel {

    let articleTitle: String
    let likes_count: String
    let url: String

    init(json: JSON) {
        self.articleTitle = json["title"].string ?? ""
        self.likes_count = json["likes_count"].description 
        self.url = json["url"].string ?? ""

    }

}
