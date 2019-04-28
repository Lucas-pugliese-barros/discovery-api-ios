//
//  DatabaseManager.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 13/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation
import SQLite3

class DatabaseManager {
    
    var dbName = "ApisDatabase.sqlite"
    
    init() {
    }
    
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbName)
        
        if (sqlite3_open(fileURL.path, &db) != SQLITE_OK) {
            print("error opening database")
        }
        
        return db
    }
    
    func createTables() {
        let db = self.openDatabase()
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Apis (id TEXT, kind TEXT, name TEXT, version TEXT, title TEXT, description TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }
}
