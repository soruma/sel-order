//
//  OrderTableViewController.swift
//  SelOrder
//
//  Created by soruma.net on 1/1/18.
//  Copyright © 2018 soruma. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class OrderTableViewController: UITableViewController {

    var orderDetails = [OrderDetail]()
    var products = Dictionary<Int, Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let productName = cell.viewWithTag(1) as! UILabel
        productName.text = products[orderDetails[indexPath.row].productId]?.name
        
        let orderNum = cell.viewWithTag(2) as! UILabel
        orderNum.text = orderDetails[indexPath.row].orderNum.description

        return cell
    }

    @IBAction func confirm(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "注文", message: "注文しますか?", preferredStyle:  UIAlertControllerStyle.alert)
        
        // OK
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction!) -> Void in
            print("OK")
        })
        
        // cancel
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // alert display
        present(alert, animated: true, completion: nil)
    }
}
