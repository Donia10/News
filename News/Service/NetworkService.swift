//
//  NetworkLayer.swift
//  News
//
//  Created by Donia Ashraf on 7/16/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func getNews(page:Int,completion: @escaping ([Article]?, Error?) -> ())
    func search(withsearch:String,completion: @escaping ([Article]?, Error?) -> ())

}
class NetworkService :NetworkServiceProtocol{
    func getNews(page:Int,completion: @escaping ([Article]?, Error?) -> ()) {
        
        AF.request(URLs.getNews(page: page)).validate().responseDecodable(of: News.self) { (response) in

               switch response.result {
                   case .success( _):

                       guard let data = response.value else { return }
                       completion(data.articles, nil)

                   case .failure(let error):

                       print(error)
                       completion(nil, error)
               }
           }
       }
    func search(withsearch:String,completion: @escaping ([Article]?, Error?) -> ()) {
        
        AF.request(URLs.search(with: withsearch)).validate().responseDecodable(of: News.self) { (response) in

               switch response.result {
                   case .success( _):

                       guard let data = response.value else { return }
                       completion(data.articles, nil)

                   case .failure(let error):

                       print(error)
                       completion(nil, error)
               }
           }
       }
}
