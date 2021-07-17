//
//  News.swift
//  News
//
//  Created by Donia Ashraf on 7/16/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import Foundation
struct News :Codable{
    let status:String
    let totalResults:Int
    let articles:[Article]
}
struct Article :Codable {
    let title:String
    let description:String
    let author:String
    let source:Source
    let content:String
    let imageUrl:String
    let sourceUrl:String
    let date:String
    
    enum CodingKeys : String,CodingKey {
        case title = "title"
        case description = "description"
        case author = "author"
        case source = "source"
        case content = "content"
        case imageUrl = "urlToImage"
        case sourceUrl = "url"
        case date = "publishedAt"
    }
}
struct Source:Codable{
    let id:String?
    let name:String
}

