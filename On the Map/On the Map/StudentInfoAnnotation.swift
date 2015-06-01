//
//  StudentInfoAnnotation.swift
//  On the Map
//
//  Created by Ken Hahn on 6/1/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import MapKit

class StudentInfoAnnotation: NSObject, MKAnnotation {
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    init(studentInfo: StudentInformation) {
        self.title = studentInfo.firstName + " " + studentInfo.lastName
        self.subtitle = studentInfo.mediaURL
        self.coordinate = CLLocationCoordinate2D(latitude: studentInfo.latitude, longitude: studentInfo.longitude)
        
        super.init()
    }
}
