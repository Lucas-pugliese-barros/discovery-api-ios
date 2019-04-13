//
//  ApiService.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 13/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

class ApiRemoteService {
    
    var controller: ApiTableViewController?
    
    init(controller: ApiTableViewController) {
        self.controller = controller
    }
    
    func getAll() {        
        let pr = ApiRemoteRepository()
        pr.delegate = self
        pr.getAll()
    }
    
    func OnSucess(discoveryApis: DiscoveryApis) {
        self.controller?.updateApiList(discoveryApis: discoveryApis)
    }
}
