//
//  MenuCollectionViewCell.swift
//  SelOrder
//
//  Created by soruma on 2017/12/17.
//  Copyright © 2017年 soruma. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numberOfOrdersLabel: UILabel!

    // 最大値
    let maximum = 10
    // 最大値
    let minimum = 0
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    func setCell(productTableCol: ProductTableCol) {
        self.nameLabel.text = productTableCol.product.name
        self.productImageView.image = productTableCol.image
        self.numberOfOrdersLabel.text = productTableCol.orderNum.description
    }
    
    func add() {
        var num:Int = Int(numberOfOrdersLabel.text!)!
        num += 1
        if num > maximum {
            num = maximum
        }
        numberOfOrdersLabel.text = String(num)
    }
    
    func sub() {
        var num:Int = Int(numberOfOrdersLabel.text!)!
        num -= 1
        if num < minimum {
            num = minimum
        }
        numberOfOrdersLabel.text = String(num)
    }
    
}
