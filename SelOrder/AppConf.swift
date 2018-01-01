//
//  AppConf.swift
//  SelOrder
//
//  Created by soruma.net on 1/1/18.
//  Copyright © 2018 soruma. All rights reserved.
//

import Foundation

final class AppConf {
    
    private static let sharedInstance = AppConf()
    private var configuration: String
    private var variables: [String: AnyObject]
    
    private init() {
        
        // Singletonの確認用
        print("Configuration initialization")
        
        let mainBundle = Bundle.main
        // Fetch Current Configuration
        self.configuration = (mainBundle.infoDictionary?["Configuration"]) as! String
        
        // Load Configurations
        guard let path = mainBundle.path(forResource: "Configurations", ofType: "plist") else {
            self.variables = [:]
            return
        }
        let configurations =  NSDictionary(contentsOfFile: path)
        // Load Variables for Current Configuration
        self.variables = configurations?.object(forKey: self.configuration) as! [String : AnyObject]
    }
    
    class func Configuration() -> String {
        return sharedInstance.configuration
    }
    
    class func APIEndpoint() -> String {
        guard let endpoint = sharedInstance.variables["APIEndpoint"] else {
            return ""
        }
        return endpoint as! String
    }
}
