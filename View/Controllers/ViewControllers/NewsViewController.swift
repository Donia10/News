//
//  ViewController.swift
//  News
//
//  Created by Donia Ashraf on 7/16/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet private weak var newsSearch: UISearchBar!
    @IBOutlet private weak var newsTableView: UITableView!
    @IBOutlet weak var loadingData: UIActivityIndicatorView!
    @IBOutlet weak var loadMore: UIActivityIndicatorView!
    private let newsViewModel = NewsViewModel()
    private var articles = [Article]()
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsSearch.layer.cornerRadius = newsSearch.frame.height/2
        newsTableView.reloadData()
        newsSearch.delegate = self
        newsViewModel.getNewsList(page: page)
        newsViewModel.bindNewsToView = onSuccessUpdateView
        newsViewModel.bindErrorToView = onFailUpdateView
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // loadingData.startAnimating()
        if !NewsViewModel.isConnected()
        {
            let alert = UIAlertController(title: "No Internet Connection", message: "please Check your internet connection ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func bindNews() {
        
    }
    func onSuccessUpdateView() {
        
        guard let articles = newsViewModel.articles else{
            return
        }
        for article in articles {
            self.articles.append(article)
            
        }
        loadingData.stopAnimating()
        //   loadMore.stopAnimating()
        print("articlesCount =\(self.articles.count)")
        newsTableView.reloadData()
        
    }
    
    func onFailUpdateView() {
        //  self.loading.stopAnimating()
        let alert = UIAlertController(title: "Error", message: newsViewModel.error, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
            
        }
        
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}
extension NewsViewController :UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        let article = articles[indexPath.row]
        
        cell.newsCell = newsViewModel.getNewsCell(from:article)
        //    cell.layer.borderColor = UIColor.black as! CGColor
        cell.delegate = self
        if indexPath.row == articles.count - 1 {
            if articles.count < 100 {
                //       loadMore.startAnimating()
                page = page + 1
                newsViewModel.getNewsList(page:page)
                newsViewModel.bindNewsToView = onSuccessUpdateView
                //   print(" articles count updated = \(articles.count)")
            }
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let detailsViewController = (storyboard?.instantiateViewController(withIdentifier: "NewsDetailsTableViewController")) as? NewsDetailsTableViewController else {
            return
        }
        detailsViewController.article = newsViewModel.getArticle(from: articles[indexPath.row])
        
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
}

extension NewsViewController:NewsDelegate{
    func onSourceButtonPressed(from cell: NewsTableViewCell) {
        guard  let webViewViewController = (storyboard?.instantiateViewController(withIdentifier: "WebViewViewController")) as? WebViewViewController else {
            return
        }
        
        webViewViewController.url = cell.newsCell?.sourceUrl
        
        navigationController?.pushViewController(webViewViewController, animated: true)
        
    }
    
    
}
extension NewsViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            articles = [Article]()
            
            newsViewModel.getNewsList(page: 1)
            newsViewModel.bindNewsToView = onSuccessUpdateView
        }
        if searchText.count > 2 {
            print(searchText)
            search(withSearchText:searchText)
        }
    }
    func search(withSearchText:String){
        newsViewModel.search(withQ: withSearchText)
        newsViewModel.resultOfSearch = {
            [weak self] in
            self?.articles = [Article]()
            
            guard let articles = self?.newsViewModel.searchedArticles else{
                return
            }
            for article in articles {
                self?.articles.append(article)
                
            }
            print("articlesCount search =\(self?.articles.count)")
            self?.newsTableView.reloadData()
            
        }
    }
}
