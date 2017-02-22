//
//  Movie.swift
//  MovieReviewReader
//
//  Created by Pet Minuta on 20/02/2017.
//  Copyright © 2017 Luka Sonjic. All rights reserved.
//

import Foundation
import UIKit

struct Movie {
    var reviewer: String
    var date: String
    var movieTitle: String
    var reviewTitle: String
    var summary: String
    var linkText: String
    var imageURL: String
    var linkURL: String
    var image: UIImage?
    
    init(reviewer: String, date: String, movieTitle: String, reviewTitle: String, summary: String, linkText: String, imageURL: String, linkURL: String, image: UIImage?) {
        self.reviewer = reviewer
        self.date = date
        self.movieTitle = movieTitle
        self.reviewTitle = reviewTitle
        self.summary = summary
        self.linkText = linkText
        self.linkURL = linkURL
        self.imageURL = imageURL
        
    }
    
}
