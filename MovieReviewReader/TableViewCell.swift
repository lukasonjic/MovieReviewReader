//
//  TableViewCell.swift
//  MovieReviewReader
//
//  Created by Pet Minuta on 17/02/2017.
//  Copyright © 2017 Luka Sonjic. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        movieNameLabel.text = "ReviewTitle"
        movieImageView.image = UIImage(named: "mock")
    }

    
    func setup(image: UIImage, reviewTitle: String){
        movieNameLabel.text = reviewTitle
        movieImageView.image = image
    }
    
}
