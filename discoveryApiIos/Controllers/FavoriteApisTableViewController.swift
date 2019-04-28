//
//  FavoriteApisTableViewController.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 13/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class FavoriteApisTableViewController: UITableViewController {
     
    var apiLocalService: ApiLocalService?
    var items:[Api]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiLocalService = ApiLocalService()
        items = apiLocalService?.getAllFavoritesApis()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteApiCell", for: indexPath) as! FavoriteApiViewCell
        
        let item = items?[indexPath.row]
        
        if(cell.titulo != nil) {
            cell.titulo.font = UIFont.boldSystemFont(ofSize: 16.0)
            cell.titulo.text = item?.title
        }
        
        if(cell.descricao != nil) {
            cell.descricao.text = item?.description
        }
        
        return cell
    }
    
}
