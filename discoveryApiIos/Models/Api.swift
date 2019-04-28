//
//  File.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 06/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

struct Api: Codable {
    
    var id: String
    var kind: String
    var name: String
    var version: String
    var title: String
    var description: String
    var isFavorite: Bool?
    
    init(id: String, kind: String, name: String, version: String, title: String, description: String) {
        self.id = id
        self.kind = kind
        self.name = name
        self.version = version
        self.title = title
        self.description = description
        self.isFavorite = false
    }
    
}
