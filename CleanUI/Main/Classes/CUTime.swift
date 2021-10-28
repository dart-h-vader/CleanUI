//
//  Copyright © 2021 - present Julian Gerhards
//  GitHub https://github.com/knoggl/CleanUI
//

import SwiftUI
import Combine

/// This is a time / Date helper class
public class CUTime {
    
    static let dateFormatter = DateFormatter()
    
    /// Converts seconds to a String like 03:46
    /// - Parameter seconds: The seconds
    /// - Returns: A String like 03:46
    public static func secondsToMinutesAndSecondsString(seconds : Int) -> String {
        let minutesF = (seconds % 3600) / 60
        let secondsF = (seconds % 3600) % 60
        return  "\(String(format: "%02d", minutesF)):\(String(format: "%02d", secondsF))"
    }
    
    /// Converts the user local time ISO8601 to server (UTC) ISO8601 time
    /// - Parameter dateStr: The ISO8601 timestamp String
    /// - Returns: The server (UTC)  ISO8601 timestamp String
    public static func localToServerTime(dateStr: String) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    /// Converts the server time (UTC) ISO8601 to user local time
    /// - Parameter dateStr: The (UTC)  ISO8601 timestamp String
    /// - Returns: The local ISO8601 timestamp String
    public static func serverToLocalTime(dateStr: String) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    
    /// Converts an ISO8601 timestamp String to a Date
    /// - Parameter timestamp: The ISO8601 timestamp String
    /// - Returns: The Date
    public static func timestampStringToDate(timestamp: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: timestamp) {
            return date
        }
        
        return nil
    }
    
    /// Converts an ISO8601 timestamp String to a human readable format like german: (Mittwoch, Sept. 29, 2021 05:23)
    /// - Parameter timestamp: The ISO8601 timestamp String
    /// - Returns: The human readable time format String
    public static func timestampToHumanReadable(timestamp: String) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let date = dateFormatter.date(from: timestamp) {
            dateFormatter.dateFormat = CULanguage.getString("dateformat")
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
