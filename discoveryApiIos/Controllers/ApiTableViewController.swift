//
//  ApiTableViewController.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 11/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class ApiTableViewController: UITableViewController {

    var databaseManager: DatabaseManager?
    var apiRemoteService: ApiRemoteService?
    var apiLocalService: ApiLocalService?
    
    var discoveryApi = DiscoveryApis()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseManager = DatabaseManager()
        apiRemoteService = ApiRemoteService(controller: self)
        apiLocalService = ApiLocalService()
        
        apiRemoteService?.getAll()
        databaseManager?.createTables()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveryApi.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! ApiViewCell

        let item = discoveryApi.items[indexPath.row]
        
        if(indexPath.row == 1) {
            apiLocalService?.insert(api: item)
        }
        
        if cell.titulo != nil {
            cell.titulo.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.titulo.text = item.title
        }
        
        if cell.descricao != nil {
            cell.descricao.text = item.description
        }

        return cell
    }
    
    func updateApiList(discoveryApis: DiscoveryApis) {
        self.discoveryApi = discoveryApis
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
