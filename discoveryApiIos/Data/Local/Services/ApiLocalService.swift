//
//  ApiLocalService.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 13/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation
import SQLite3

class ApiLocalService {
    
    var databaseManager: DatabaseManager?
    var db: OpaquePointer?
    
    init() {
        databaseManager = DatabaseManager()
        self.db = databaseManager?.openDatabase()
    }
    
    func insert(api: Api) {
        let insertStatementString = "INSERT INTO Apis (id, kind, name, version, title, description) VALUES (?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil)) == SQLITE_OK {
            let id = api.id
            let kind = api.kind
            let name = api.name
            let version = api.version
            let title = api.title
            let description = api.description
            
            sqlite3_bind_text(insertStatement, 1, id, -1, nil)
            sqlite3_bind_text(insertStatement, 2, kind, -1, nil)
            sqlite3_bind_text(insertStatement, 3, name, -1, nil)
            sqlite3_bind_text(insertStatement, 4, version, -1, nil)
            sqlite3_bind_text(insertStatement, 5, title, -1, nil)
            sqlite3_bind_text(insertStatement, 6, description, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func getAllFavoritesApis() -> [Api] {
        var apis = [Api]()
        let queryString = "SELECT * FROM Apis;"
        
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing query: \(errmsg)")
        }
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let kind = String(cString: sqlite3_column_text(stmt, 1))
            let name = String(cString: sqlite3_column_text(stmt, 2))
            let version = String(cString: sqlite3_column_text(stmt, 3))
            let title = String(cString: sqlite3_column_text(stmt, 4))
            let description = String(cString: sqlite3_column_text(stmt, 5))
            
            apis.append(Api(id: String(id), kind: String(kind), name: String(name),
                            version: String(version), title: String(title), description: String(description)))
        }
        
        return apis
    }
    
    func deleteAll () {
        let sql = "DELETE FROM Apis;"
        var stmt:OpaquePointer?
        
        if sqlite3_prepare(db, sql, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing sql to delete: \(errmsg)")
        }
        while(sqlite3_step(stmt) == SQLITE_ROW) {}
    }
}

