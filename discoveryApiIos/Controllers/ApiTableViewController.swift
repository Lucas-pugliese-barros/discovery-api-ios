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
    
    var checkBox = UIImage(named: "checkbox")
    var uncheckBox = UIImage(named: "uncheckbox")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseManager = DatabaseManager()
        apiLocalService = ApiLocalService()
        apiRemoteService = ApiRemoteService(controller: self)
        
        databaseManager?.createTables()
        apiRemoteService?.getAll()
    }
    
    @objc func tapButton() {
        print("Clicked")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveryApi.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "apiCell", for: indexPath) as! ApiViewCell
        
        discoveryApi.items[indexPath.row].isFavorite = false
        let item = discoveryApi.items[indexPath.row]
        
        if(cell.titulo != nil) {
            cell.titulo.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.titulo.text = item.title
        }
        
        if(cell.descricao != nil) {
            cell.descricao.text = item.description
        }
        
        cell.favoritar.tag = indexPath.row
        
        cell.favoritar.addTarget(self, action: #selector(onFavoritarClicked(_:)), for: .touchUpInside)

        return cell
    }
    
    @objc func onFavoritarClicked(_ sender: UIButton) {
        var api = discoveryApi.items[sender.tag]
        apiLocalService?.insert(api: api)
        
        if(api.isFavorite == true) {
            api.isFavorite = false
            sender.setImage(uncheckBox, for: UIControl.State.normal)
        } else {
            api.isFavorite = true
            sender.setImage(checkBox, for: UIControl.State.normal)
        }
        
        discoveryApi.items[sender.tag] = api
    }
    
    func updateApiList(discoveryApis: DiscoveryApis) {
        self.discoveryApi = discoveryApis
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
