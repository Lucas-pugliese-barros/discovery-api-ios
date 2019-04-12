//
//  DiscoveryApis.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 06/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

struct DiscoveryApis: Codable {
    
    var kind: String
    var discoveryVersion: String
    var items:[Api]
    
    init() {
        self.kind = ""
        self.discoveryVersion = ""
        self.items = []
    }
}
