//
//  NewsViewModel.swift
//  News
//
//  Created by Donia Ashraf on 7/16/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import Foundation

protocol NewsViewModelProtocol {
    var articles:[Article]?{
        get set
    }
    
    var searchedArticles :[Article]? { get set }
    var error :String? {get set }
    var bindNewsToView:(()->()){get set}
    var bindErrorToView:(()->()) {get set }
    var resultOfSearch:(()->()){get set }
    
}
class NewsViewModel :NewsViewModelProtocol {
    
    private var networkService :NetworkServiceProtocol
    var articles:[Article]?{
        didSet {
            self.bindNewsToView()
        }
    }
    var searchedArticles :[Article]?{
        didSet {
            self.resultOfSearch()
        }
    }
    var error :String?{
        didSet {
            self.bindErrorToView()
        }
    }
    var bindNewsToView:(()->()) = {}
    var bindErrorToView:(()->()) = {}
    var resultOfSearch:(()->()) = {}
    
    init(networkService :NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
        
    }
    
    func getNewsList(page:Int){
        networkService.getNews(page: page){[weak self]
            (articles,error) in
            if let error:Error = error {
                let message = error.localizedDescription
                self?.error = message
            }else {
                if let articles = articles {
                    self?.articles = articles
                }
                
            }
        }
        
    }
    func search(withQ:String){
        print("search view model")
        networkService.search(withsearch: withQ){[weak self]
            (articles,error) in
            if let error:Error = error {
                //       let message = error.localizedDescription
                //     self?.error = message
            }else {
                if let articles = articles {
                    self?.searchedArticles = articles
                    print("sdkf")
                    print(self?.searchedArticles?.count)
                }
                
            }
        }
        
    }
    func getArticle(from article:Article)->Article {
        return Article(title: article.title, description: article.description, author: article.author, source: article.source, content: article.content, imageUrl: article.imageUrl, sourceUrl: article.sourceUrl, date: formatDate(date: article.date))
    }
    func getNewsCell(from article:Article)-> NewsCell{
        return  NewsCell(title: article.title, imageUrl: article.imageUrl, sourceUrl: article.sourceUrl)
    }
    private func formatDate(date:String) -> String {
        var result = date.split { (char) -> Bool in
            return char == "T"
        }
        
        let d = result[0].split { (char) -> Bool in
            return char == "-"
        }
        
        let date = "\(d[2])-\(d[1])-\(d[0])"
        (result[1].remove(at: result[1].index(before: result[1].endIndex)))
        let t = result[1].split { (char) -> Bool in
            return char == ":"
        }
        let time = "\(t[0]):\(t[1])"
        
        return"\(date) \(time)"
        
        
    }
    static func isConnected() -> Bool {
        return Connectivity.isConnectedToInternet
        
    }
    
}

