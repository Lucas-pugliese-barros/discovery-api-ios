//
//  ViewController.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 06/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var discoveryApi = DiscoveryApis()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.register(ApiViewCell.self, forCellReuseIdentifier: "ApiViewCell")
        // Do any additional setup after loading the view, typically from a nib.
        
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
            
            self.discoveryApi = try! decoder.decode(DiscoveryApis.self, from: json!)
            
            print(self.discoveryApi)
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.discoveryApi.items.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ApiViewCell", for: indexPath) as! ApiViewCell
        
        cell.title?.text = "Title"
        cell.descript?.text = "Description"
        
        return cell
    }
}

