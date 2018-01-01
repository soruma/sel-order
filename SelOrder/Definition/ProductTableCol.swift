//
//  ProductTableCol.swift
//  SelOrder
//
//  Created by soruma.net on 12/31/17.
//  Copyright © 2017 soruma. All rights reserved.
//

import UIKit

class ProductTableCol: NSObject {
    
    var product: Product
    
    var image: UIImage
    
    var orderNum: Int
    
    init(product: Product) {
        self.product = product
        image = ProductTableCol.getImage(product: product)
        orderNum = 0
    }
    
    init(product: Product, orderNum: Int) {
        self.product = product
        image = ProductTableCol.getImage(product: product)
        self.orderNum = orderNum
    }
    
    static func getImage(product: Product) -> UIImage {
        let urlStr = AppConf.APIEndpoint() + product.imageUrl
        let url = URL(string: urlStr)!
        let imageData = try? Data(contentsOf: url)
        return UIImage(data: imageData!)!
    }
}
