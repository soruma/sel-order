//
//  Product.swift
//  SelOrder
//
//  Created by soruma on 2017/12/17.
//  Copyright © 2017年 soruma. All rights reserved.
//
import UIKit

/**
 料理
 */
struct Product: Codable {
    
    // MARK - Properties
    /**
     料理ID
     */
    var productId: Int
    
    /**
     料理名
    */
    var name: String

    /**
     価格
     */
    var price: Int
    
    /**
     画像URL
     */
    var imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case productId = "id"
        case name
        case imageUrl = "image_url"
        case price
    }
}
