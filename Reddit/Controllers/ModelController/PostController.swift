//
//  PostController.swift
//  Reddit
//
//  Created by Alex Kennedy on 9/23/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

class PostController {
    
    struct StringConstants {
        fileprivate static let baseURL = "https://www.reddit.com"
        fileprivate static let rEndpoint = "r"
        fileprivate static let funnyEndpoint = "funny"
        fileprivate static let jsonExtension = "json"
    }
    
    // in result<>, the first option is the success case, second is the failure case
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL)) }
        let rComponentURL = baseURL.appendingPathComponent(StringConstants.rEndpoint)
        let funnyComponentURL = rComponentURL.appendingPathComponent(StringConstants.funnyEndpoint)
        let finalURL = funnyComponentURL.appendingPathExtension(StringConstants.jsonExtension)
        print(finalURL)
    }
}
