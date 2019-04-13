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
        let insertStatementString = "INSERT INTO Apis (Id, Name) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(self.db, insertStatementString, -1, &insertStatement, nil)) == SQLITE_OK {
            let id = api.id
            let name = api.name
            
            sqlite3_bind_text(insertStatement, 1, id, -1, nil)
            
            sqlite3_bind_text(insertStatement, 2, name, -1, nil)
            
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

}
