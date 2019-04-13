//
//  ApiTableViewController.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 11/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class ApiTableViewController: UITableViewController {

    var discoveryApi = DiscoveryApis()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.discoveryApi.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! ApiViewCell

        let item = self.discoveryApi.items[indexPath.row]
        
        if cell.titulo != nil {
            cell.titulo.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.titulo.text = item.title
        }
        
        if cell.descricao != nil {
            cell.descricao.text = item.description
        }

        return cell
    }

}
