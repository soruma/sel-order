//
//  OrderDetail.swift
//  SelOrder
//
//  Created by soruma on 2017/12/17.
//  Copyright © 2017年 soruma. All rights reserved.
//

/**
 注文項目
 */
struct OrderDetail: Codable {

    // MARK - Properties
    /**
     注文ID
     */
    var orderId: Int

    /**
     商品ID
     */
    var productId: Int
    
    /**
     注文数
     */
    var orderNum: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case productId = "product_id"
        case orderNum = "order_num"
    }
}
