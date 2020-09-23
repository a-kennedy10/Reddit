//
//  PostError.swift
//  Reddit
//
//  Created by Alex Kennedy on 9/23/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case thrownImageError(Error)
    case unableToDecode
}
