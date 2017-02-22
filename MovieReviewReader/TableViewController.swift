//
//  TableViewController.swift
//  MovieReviewReader
//
//  Created by Pet Minuta on 17/02/2017.
//  Copyright © 2017 Luka Sonjic. All rights reserved.
//

import UIKit
import SwiftyJSON
import Dispatch



class TableViewController: UITableViewController {
    var request: URLRequest?
    var movies = [Movie]()
    let URLString = "https://api.nytimes.com/svc/movies/v2/reviews/search.json?api-key=5822744dc0f64a15be6bf1e0ace6a0d3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib.init(nibName: "TableViewCell", bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: "TableViewCell")

        let url = URL(string: URLString)
        request = URLRequest(url: url!)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.handleAppActivation()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.title = "Movie Review Reader"
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAppActivation),
            name: NSNotification.Name.UIApplicationWillEnterForeground,
            object: nil
        )
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let url = URL(string: movies[indexPath.item].imageURL)
        
        DispatchQueue.global().async {
            if let url = url {
                if let data = try? Data(contentsOf: url){
                    DispatchQueue.main.sync {
                        if let image = UIImage(data: data) {
                            for i in 0..<self.movies.count {
                                if url.absoluteString == self.movies[i].imageURL {
                                    self.movies[i].image = image
                                }
                            }
                            cell.setup(image: image, reviewTitle: self.movies[indexPath.item].movieTitle)
                        }
                    }
                }
            }
            
            }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let reviewViewController = ReviewViewController(movie: movies[indexPath.item])
        navigationController?.pushViewController(reviewViewController, animated: true)
    }

    override func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let height = movies[indexPath.item].image?.size.height {
            return height
        } else {
            return 0
        }
    }

    
    private func execTask(request: URLRequest, taskCallback: @escaping (Bool,
        AnyObject?) -> ()) {
    
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                let json = JSON(data: data, options: JSONSerialization.ReadingOptions.mutableContainers, error: nil)
                if let number = Int(json["num_results"].stringValue){
                    for i in 0..<number {
                        let movie = Movie.init(reviewer: json["results"][i]["byline"].stringValue, date: json["results"][i]["publication_date"].stringValue, movieTitle: json["results"][i]["display_title"].stringValue, reviewTitle: json["results"][i]["headline"].stringValue, summary: json["results"][i]["summary_short"].stringValue, linkText: json["results"][i]["link"]["suggested_link_text"].stringValue, imageURL: json["results"][i]["multimedia"]["src"].stringValue, linkURL: json["results"][i]["link"]["url"].stringValue,
                            image: nil)
                        self.movies.append(movie)
                    }
                    
                }
                
                
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    taskCallback(true, json as AnyObject?)
                } else {
                    taskCallback(false, json as AnyObject?)
                }
            }
        })
        task.resume()
    }

    @objc func handleAppActivation() {
        DispatchQueue.global(qos: .background).sync {
            if let request = self.request {
                
                execTask(request: request) { [weak self](ok, obj) in
                    DispatchQueue.main.sync {
                        self?.tableView.reloadData()
                        print("da")
                    }
                }
            }
            
        }
        
    }
    
}
