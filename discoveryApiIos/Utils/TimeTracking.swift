//
//  TimeTracking.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 30/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

class TimeTracking {
    
    private static var timeHistories = [String: [Date]]()
    
    public static func recordTime(tag: String, message: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date()
        
        let dateString = formatter.string(from: date)
        print(tag + " - " + message + " : " + dateString)
        
        timeHistories = updateHistory(timeHistory: timeHistories, tag: tag, date: date)
    }
    
    private static func updateHistory(timeHistory: [String: [Date]], tag: String, date: Date) -> [String: [Date]] {
        return (timeHistory.keys.contains(tag)) ?
            addTimeForTag(timeHistory: timeHistory, tag: tag, date: date) : newTagWithTime(timeHistory: timeHistory, tag: tag, date: date)
    }
    
    private static func addTimeForTag(timeHistory: [String: [Date]], tag: String, date: Date) -> [String: [Date]] {
        var history = timeHistory
        var dates = history[tag]
        dates?.append(date)
        
        history.updateValue(dates!, forKey: tag)
        
        return history
    }
    
    private static func newTagWithTime(timeHistory: [String: [Date]], tag: String, date: Date) -> [String: [Date]] {
        var history = timeHistory
        var dates = [Date]()
        dates.append(date)
        
        history[tag] = dates
        
        return history
    }
}
