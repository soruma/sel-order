//
//  Order.swift
//  SelOrder
//
//  Created by soruma.net on 12/31/17.
//  Copyright © 2017 soruma. All rights reserved.
//

/**
 注文
 */
struct Order: Codable {
    
    // MARK - Properties
    /**
     注文ID
     */
    var orderId: Int
 
    /**
     卓ID
     */
    var tableNum: Int
    
    /**
     注文明細
     */
    var orderDetails: [OrderDetail]
    
    enum CodingKeys: String, CodingKey {
        case orderId = "id"
        case tableNum = "table_num"
        case orderDetails
    }
}
