//
//  StudentInformation.swift
//  On the Map
//
//  Created by Ken Hahn on 5/31/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import MapKit

struct StudentInformation {
    init(dict: [String: AnyObject]) {
        objectId = dict["objectId"] as! String
        uniqueKey = dict["uniqueKey"] as! String
        firstName = dict["firstName"] as! String
        lastName = dict["lastName"] as! String
        mapString = dict["mapString"] as! String
        mediaURL = dict["mediaURL"] as! String
        latitude = dict["latitude"] as! Double
        longitude = dict["longitude"] as! Double
    }
    
    var objectId: String
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double
    var longitude: Double
    
}
