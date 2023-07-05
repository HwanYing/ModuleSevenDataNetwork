//
//  GenreEntity.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/7/1.
//

import Foundation

extension GenreEntity {
    
    static func toMovieGenre(entity: GenreEntity) -> MovieGenre {
        MovieGenre(id: Int(entity.id ?? "0") ?? 0, name: entity.name ?? "")
    }
}
