//
//  Urls.swift
//  News
//
//  Created by Donia Ashraf on 7/16/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import Foundation
class URLs{
    private static var baseUrl = " https://newsapi.org/v2/everything?q=Apple&from=2021-07-1&sortBy=popularity&apiKey=c05fac47fac94b36b74524f3a7240ce6"
    
    static func getNews(page:Int)-> String{
 return "https://newsapi.org/v2/everything?q=Apple&pageSize=20&page=\(page)&from=2021-07-1&sortBy=popularity&apiKey=13f58a214cff4922a9fdd3416cc326e5"
        // donia100 apikey = c05fac47fac94b36b74524f3a7240ce6
    }
    static func search(with:String)->String{
        return "https:newsapi.org/v2/everything?q=\(with)&sortBy=popularity&apiKey=13f58a214cff4922a9fdd3416cc326e5"
     
 //       return baseUrl + with
    }
    
}
