//
//  WebViewController.swift
//  News
//
//  Created by Donia Ashraf on 7/17/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import UIKit
import WebKit
class WebViewViewController: UIViewController {

    @IBOutlet private weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loading.startAnimating()
        guard let url = url else{
            return
        }
        let urlRequest :URLRequest = URLRequest(url: URL(string: url)!)
        
        webView.load(urlRequest)
        loading.stopAnimating()
    }
    override func viewWillAppear(_ animated: Bool) {
        if !NewsViewModel.isConnected()
        {
            let alert = UIAlertController(title: "No Internet Connection", message: "please Check your internet connection ", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
