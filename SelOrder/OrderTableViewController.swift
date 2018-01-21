//
//  OrderTableViewController.swift
//  SelOrder
//
//  Created by soruma.net on 1/1/18.
//  Copyright © 2018 soruma. All rights reserved.
//

import UIKit
import SwiftHTTP

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
            self.passingOrder()
        })
        
        // cancel
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        // alert display
        present(alert, animated: true, completion: nil)
    }
    
    func passingOrder() {
        let url = AppConf.APIEndpoint() + "/orders"
        
        let url4 = URL(string: url)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let order = Order(id: 0, tableNum: 1, orderDetails: orderDetails)
        
        request.httpBody = try! JSONEncoder().encode(order)
        
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
        }
        task.resume()
        
        
        
        
        /*
        // TODO: tableNum
        let order = Order(id: 0, tableNum: 1, orderDetails: orderDetails)
       
        let orderParam = try! JSONEncoder().encode(order)
        JSONSerialization.s
        DispatchQueue.global(qos: .default).async {
            let url = AppConf.APIEndpoint() + "/orders"
            HTTP.POST(url, parameters: order as? HTTPParameterProtocol,requestSerializer: JSONSerialization() as! HTTPSerializeProtocol) { response in
                
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                } else {
                    // success
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            }
            */
            /*
            HTTP.POST(url, parameters: orderParam as! HTTPParameterProtocol) { response in
                if let err = response.error {
                    print("error: \(err.localizedDescription)")
                    return
                } else {
                    // success
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
 */
        //}
    }
}
