//
//  Post.swift
//  Reddit
//
//  Created by Alex Kennedy on 9/23/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import UIKit

struct TopLevelDictionary: Codable {
    let data: SecondLevelDictionary
}

struct SecondLevelDictionary: Codable {
    let children: [ThirdLevelObject] // wrap it in an array because its a bunch of objects
}

struct ThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let title: String
    let thumbnail: URL?
    let ups: Int
}
