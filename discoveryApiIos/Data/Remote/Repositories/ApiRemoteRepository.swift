//
//  ApiRepository.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 13/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

class ApiRemoteRepository {
    
    var delegate: ApiRemoteService?

    func getAll() {
        var discoveryApi = DiscoveryApis()
        
        let url = URL(string: "https://www.googleapis.com/discovery/v1/apis/")!
        let myRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: myRequest as URLRequest) {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling GET on discovery/v1/apis")
                print(error!)
                return
            }
            
            let result = String(data: data!, encoding: .utf8)
            let json = result?.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            discoveryApi = try! decoder.decode(DiscoveryApis.self, from: json!)
            
            self.delegate?.OnSucess(discoveryApis: discoveryApi)
        }
        task.resume()
    }
}
