//
//  GenreVO.swift
//  MovieAppBySwift
//
//  Created by 梁世仪 on 2023/4/4.
//

import Foundation

class GenreVO {
    var id: Int = 0
    var name: String = "ACTION"
    var isSelected: Bool = false
    
    init(id: Int, name: String, isSelected: Bool) {
        self.id = id
        self.name = name
        self.isSelected = isSelected
    }
}
