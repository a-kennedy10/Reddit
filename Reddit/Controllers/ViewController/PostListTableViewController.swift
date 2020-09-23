//
//  PostListTableViewController.swift
//  Reddit
//
//  Created by Alex Kennedy on 9/23/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    // MARK: - properties
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchposts()
    }
    
    //MARK: - helpers
    func fetchposts() {
        PostController.fetchPosts { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    //call dispatch whenever you update the view, all updates have to happen on the main thred, the fastlane thread
                    
                    self.tableView.reloadData()
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        let post = posts[indexPath.row]
        cell.post = post 
        cell.delegate = self
        
        return cell
    }
    
}

// MARK: -
extension PostListTableViewController: presentErrorToUserDelegate {
    func presentError(error: LocalizedError) {
        self.presentErrorToUser(localizedError: error)
    }
}
