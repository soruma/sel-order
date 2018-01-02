//
//  RamenCollectionViewController.swift
//  SelOrder
//
//  Created by soruma on 2017/12/17.
//  Copyright © 2017年 soruma. All rights reserved.
//

import UIKit
import SwiftHTTP

private let reuseIdentifier = "Cell"

class RamenCollectionViewController: UICollectionViewController {

    var products = Dictionary<Int, Product>()
    var orderDetails = [OrderDetail]()
    var collectionData = [ProductTableCol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        
        setInitData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOrderTable" {
            orderDetails = [OrderDetail]()
            let orderTableViewController = segue.destination as! OrderTableViewController
            collectionData.forEach{(productTableCol) in
                if productTableCol.orderNum > 0 {
                    let orderDetail = OrderDetail(orderId: 0,
                                                  productId: productTableCol.product.id,
                                                  orderNum: productTableCol.orderNum)
                    orderDetails.append(orderDetail)
                }
            }
            orderTableViewController.orderDetails = orderDetails
            orderTableViewController.products = products
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCollectionViewCell
        let productCol = collectionData[indexPath.row]
        menuCell.setCell(productTableCol: productCol)
        return menuCell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return collectionData.count;
    }
    
    func setInitData() {
        DispatchQueue.global(qos: .default).async {
            let url = AppConf.APIEndpoint() + "/products/menu/ramen"
            HTTP.GET(url, parameters: nil) { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                let productsBuf = try! JSONDecoder().decode([Product].self, from: response.data)
                productsBuf.forEach {(product) in
                    self.products[product.id] = product
                }
                
                DispatchQueue.main.async {
                    self.products.forEach {(product) in
                        self.collectionData.append(ProductTableCol(product: product.value))
                    }
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    // MARK: MenuCollectionViewCell
    @IBAction func addItem(_ sender: UIButton) {
        let cell = sender.superview?.superview as! MenuCollectionViewCell
        cell.add()
    }
    
    @IBAction func subItem(_ sender: UIButton) {
        let cell = sender.superview?.superview as! MenuCollectionViewCell
        cell.sub()
    }
}
