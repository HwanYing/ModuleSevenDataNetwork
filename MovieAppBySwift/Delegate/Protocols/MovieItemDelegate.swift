//
//  MovieItemDelegate.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/6.
//

import Foundation

enum VideoType {
    case series
    case movie
}

protocol MovieItemDelegate {
    func onTapMovieItem(id: Int)
//    func onTapViewMore(data: MovieListResult)
    
    func onTapMovie(id: Int, type: VideoType)
}

