//
//  ApiService.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 13/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

class ApiService {
    
    var controller: ApiTableViewController?
    
    init(controller: ApiTableViewController) {
        self.controller = controller
    }
    
    func consultarApis() {        
        let pr = ApiRepository()
        pr.delegate = self
        pr.consultarApis()
    }
    
    func apisConsultadasComSucesso(discoveryApis: DiscoveryApis) {
        self.controller?.updateApiList(discoveryApis: discoveryApis)
    }
}
