//
//  NewsDetailsTableViewController.swift
//  News
//
//  Created by Donia Ashraf on 7/17/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import UIKit

class NewsDetailsTableViewController: UITableViewController {
    
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var newsImgView: UIImageView!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var sourceLbl: UILabel!
    @IBOutlet private weak var authorLbl: UILabel!
    @IBOutlet private weak var dateLbl: UILabel!
    var article:Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    private func setUpUI(){
        self.navigationItem.title = "News Details"
        titleLbl.text = article?.title
        newsImgView.sd_setImage(with: URL(string: article?.imageUrl ?? ""), placeholderImage: UIImage(named: ""))
        descriptionTextView.text = article?.description
        contentTextView.text = article?.content
        sourceLbl.text = article?.source.name
        guard let author = article?.author else {
            return
        }
        authorLbl.text = "By \(author)"
        
        dateLbl.text = article?.date
    }
    
    @IBAction func navigateToSource(_ sender: Any) {
        guard let url = article?.sourceUrl else {
            return
        }
        guard  let webViewController = storyboard?.instantiateViewController(withIdentifier: "WebViewViewController") as? WebViewViewController else {
            return
        }
        webViewController.url = url
        self.navigationController?.pushViewController(webViewController, animated: true)
    }
    
}
