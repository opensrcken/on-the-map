//
//  ParseClient.swift
//  On the Map
//
//  Created by Ken Hahn on 5/31/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import Foundation
//
//  Client.swift
//  On the Map
//
//  Created by Ken Hahn on 5/14/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import UIKit

class ParseClient : NSObject {
    /* Shared session */
    var session: NSURLSession
    
    /* Authentication state */
    var sessionID : String? = nil
    var userID : Int? = nil
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    func getStudentLocations(completionHandler: (data: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.parse.com/1/classes/StudentLocation?limit=100")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                completionHandler(data: nil, error: error)
                return
            }
            let (json, error): (AnyObject!, NSError?) = JSON.parse(data)
            completionHandler(data: json, error: error)
        }
        task.resume()
        return task
    }
    
    class func sharedInstance() -> ParseClient {
        
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        
        return Singleton.sharedInstance
    }
}