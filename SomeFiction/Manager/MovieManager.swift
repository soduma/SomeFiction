//
//  MovieManager.swift
//  SomeFiction
//
//  Created by 장기화 on 2022/05/24.
//

import Foundation

class MovieManager {
    static let shared = MovieManager()
    
    private init() {}
    
    var movieList: [Movie] = []
    var likeMovieList: [Movie] = []
}
