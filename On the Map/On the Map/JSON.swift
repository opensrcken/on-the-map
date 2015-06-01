//
//  JSONParser.swift
//  On the Map
//
//  Created by Ken Hahn on 5/31/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import Foundation

struct JSON {
    static func parse(data: NSData) -> (AnyObject!, NSError?) {
        var parsingError: NSError? = nil
        
        let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
        
        if let error = parsingError {
            return (nil, error)
        } else {
            return (parsedResult, nil)
        }
    }
}