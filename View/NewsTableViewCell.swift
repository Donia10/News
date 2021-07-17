//
//  NewsTableViewCell.swift
//  News
//
//  Created by Donia Ashraf on 7/16/21.
//  Copyright © 2021 Donia Ashraf. All rights reserved.
//

import UIKit
import SDWebImage

protocol NewsDelegate:class {
    func onSourceButtonPressed(from cell:NewsTableViewCell)
}
class NewsTableViewCell: UITableViewCell {

    @IBOutlet private weak var newsImgView: UIImageView!
    @IBOutlet private weak var newsTitleLbl: UILabel!
    var delegate:NewsDelegate?
     var newsCell:NewsCell?{
        didSet{
            newsTitleLbl.text = newsCell?.title
            newsImgView.sd_setImage(with: URL(string: newsCell?.imageUrl ?? ""), placeholderImage: UIImage(named: ""))
            
        }
    }

    @IBAction func navigateToSource(_ sender: Any) {
        self.delegate?.onSourceButtonPressed(from: self)
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
