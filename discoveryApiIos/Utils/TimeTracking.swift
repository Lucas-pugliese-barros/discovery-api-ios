//
//  TimeTracking.swift
//  discoveryApiIos
//
//  Created by Rafael Pugliese on 30/04/19.
//  Copyright © 2019 Lucas Pugliese. All rights reserved.
//

import Foundation

public class TimeTracking {
    
    private static var timeHistories = [String: [Date]]()
    private static var processingTimes = [String: String]()
    
    public static func recordTime(tag: String, message: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date = Date()
        
        //let dateString = formatter.string(from: date)
        //print(tag + " - " + message + " : " + dateString)
        
        timeHistories = updateHistory(timeHistory: timeHistories, tag: tag, date: date)
        calculateProcessingTime(timeHistory: timeHistories, tag: tag);
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
    
    private static func calculateProcessingTime(timeHistory: [String: [Date]], tag: String) {
        if (timeHistory.keys.contains(tag) && timeHistory[tag]!.count % 2 == 0) {
            var dates = timeHistory[tag];
            
            let penultimateDate = dates![dates!.count - 2];
            let lastDate =  dates![dates!.count - 1];
            
            //TIME INTERVAL (IN SECONDS) * 1000 = MILLISECONDS
            let processingTime = lastDate.timeIntervalSince(penultimateDate) * 1000;
            let inMilliseconds = String(processingTime)
            processingTimes[tag] = inMilliseconds
            
            print(tag + " PROCESSING TIME: " + inMilliseconds)
            NSLog(tag + " PROCESSING TIME: " + inMilliseconds)
        }
    }
}
