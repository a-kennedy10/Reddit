//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Alex Kennedy on 9/23/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

// MARK: - protocol
protocol presentErrorToUserDelegate: AnyObject {
    func presentError(error: LocalizedError)
}


class PostTableViewCell: UITableViewCell {

    //MARK: - outlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvoteLabel: UILabel!
    
    // MARK: - properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: presentErrorToUserDelegate?
    
    
    // MARK: - helper functions and methods
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        upvoteLabel.text = "Upvotes: ⬆️ \(post.ups)"
        thumbnailImageView.image = nil
        
        PostController.fetchThumbnailFor(post: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.thumbnailImageView.image = image
                case .failure(let error):
                    self.delegate?.presentError(error: error)
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
}
