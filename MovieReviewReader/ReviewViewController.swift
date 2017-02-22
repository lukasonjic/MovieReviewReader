//
//  ReviewViewController.swift
//  MovieReviewReader
//
//  Created by Pet Minuta on 21/02/2017.
//  Copyright © 2017 Luka Sonjic. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var reviewAuthorLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var linkButton: UIButton!
    
    @IBAction func openWebView(_ sender: UIButton) {
        if let url = self.movie?.linkURL {
            let webViewController = WebViewController(url: url)
            navigationController?.pushViewController(webViewController, animated: true)
            }
    }
    
    private var movie: Movie?
    private var image: UIImage?
    
    convenience init(movie: Movie) {
        self.init()
        self.movie = movie
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieImageView.image = self.movie?.image
        self.movieTitleLabel.text = self.movie?.movieTitle
        self.reviewDateLabel.text = self.movie?.date
        self.reviewAuthorLabel.text = self.movie?.reviewer
        self.summaryLabel.text = self.movie?.summary
        self.navigationItem.title = self.movie?.movieTitle
        self.linkButton.setTitle(self.movie?.linkText, for: .normal)
        self.linkButton.isHidden = true
        self.linkButton.titleLabel?.numberOfLines = 0
        self.linkButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.linkButton.titleLabel?.lineBreakMode = .byClipping
        
        self.setAlpha(value: 0)
        self.setFrame(x: UIScreen.main.bounds.width)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.setAlpha(value: 1)
            self.setFrame(x: 0)
        }, completion: { _ in
            self.linkButton.isHidden = false
        })
        
    }
    
    private func setFrame(x: CGFloat) {
        self.movieTitleLabel.frame.origin.x = x
        self.reviewDateLabel.frame.origin.x = x
        self.reviewAuthorLabel.frame.origin.x = x
    }
    
    private func setAlpha(value: CGFloat) {
        self.movieTitleLabel.alpha = value
        self.reviewDateLabel.alpha = value
        self.reviewAuthorLabel.alpha = value
    }
}
