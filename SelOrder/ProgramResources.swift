//
//  ProgramResources.swift
//  SelOrder
//
//  Created by soruma.net on 12/30/17.
//  Copyright © 2017 soruma. All rights reserved.
//

import UIKit

// サーバーの変数を持った構造体
struct ProgramResources {
    static let serverUrl = "http://192.168.11.11:3000"
    
    static func serverUrlConnection(urlString: String) -> String {
        // TODO: urlの最初が"/"の場合はコンバートをかける
        return serverUrl + urlString
    }
}
