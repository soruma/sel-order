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

    var collectionData = [ProductTableCol]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = false
        
        setInitData()
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
            let url = AppConf.APIEndpoint() + "/products"
            HTTP.GET(url, parameters: nil) { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                }
                let products: [Product] = try! JSONDecoder().decode([Product].self, from: response.data)

                DispatchQueue.main.async {
                    products.forEach {(product) in
                        self.collectionData.append(ProductTableCol(product: product))
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
