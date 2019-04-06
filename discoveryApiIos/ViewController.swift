//
//  ViewController.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 06/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://www.googleapis.com/discovery/v1/apis")!
        let myRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: myRequest as URLRequest) {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling GET on discovery/v1/apis")
                print(error!)
                return
            }
            
            let myData = String(data: data, encoding: .utf8)
            let json = myData?.data(using: .utf8)!
            
        }
        
        task.resume()
        
    }

    
}

