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
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do { // have to decode from the top
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                // drilling down into the decoded data to get what we need
                let secondLevelDictionary = topLevelDictionary.data
                let thirdLevelObjects = secondLevelDictionary.children
                // pulling the posts out of each third level object in the array
                var postsPlaceholderArray: [Post] = []
                
                for object in thirdLevelObjects {
                    let post = object.data
                    // attaching the posts to the placeholder array
                    postsPlaceholderArray.append(post)
                }
                completion(.success(postsPlaceholderArray))
                
            } catch {
                return completion(.failure(.thrownError(error)))
            }
            
        }.resume()
    }
    
    static func fetchThumbnailFor(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        guard let url = post.thumbnail else { return completion(.failure(.invalidURL)) }
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownImageError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let thumbnailImage = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            completion(.success(thumbnailImage))
            
        }.resume()
    }
    
    
    
    
}
