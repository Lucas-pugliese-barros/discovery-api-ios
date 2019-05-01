//
//  ApiTableViewController.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 11/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import UIKit

class ApiTableViewController: UITableViewController {

    let TAG_REMOTE = " REMOTE "
    let TAG_LIST_REMOTE = " LIST_REMOTE "
    let TAG_LIKE_API = " LIKE_API "
    
    
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
        
        TimeTracking.recordTime(tag: TAG_REMOTE, message: "loadApiList")
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

        if(indexPath.row == 3) {
            TimeTracking.recordTime(tag: TAG_LIST_REMOTE, message: "apisListLoaded")
        }
        
        return cell
    }
    
    @objc func onFavoritarClicked(_ sender: UIButton) {
        var api = discoveryApi.items[sender.tag]
        
        trackLikeProcessingTime(TAG: TAG_LIKE_API, message: "likeApi", position: sender.tag)
        apiLocalService?.insert(api: api)
        trackLikeProcessingTime(TAG: TAG_LIKE_API, message: "apiLiked", position: sender.tag)
        
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
        TimeTracking.recordTime(tag: TAG_REMOTE, message: "updateApiList")
        self.discoveryApi = discoveryApis
        
        TimeTracking.recordTime(tag: TAG_LIST_REMOTE, message: "addingApisToList")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func trackLikeProcessingTime(TAG: String, message: String, position: Int) {
        if(position == 0 ) {
            TimeTracking.recordTime(tag: TAG_LIKE_API, message: message)
        }
    }
}
