//
//  CategoryItem.swift
//  MoveAround
//
//  Created by Ngan, Naomi on 10/20/17.
//  Copyright © 2017 Mohit Taneja. All rights reserved.
//
import Foundation

class CategoryItem {
    private var item: Category
    
    var isSelected = false
    var name: String {
        return item.name
    }
    var yelpCode: String {
        return item.yelpCode
    }
    
    var imageName: String {
        return item.imageName
    }
    
    init(item: Category) {
        self.item = item
    }
    
}
