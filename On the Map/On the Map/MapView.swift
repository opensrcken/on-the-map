//
//  MapView.swift
//  On the Map
//
//  Created by Ken Hahn on 5/23/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import UIKit
import MapKit

class MapView : UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var accountId: Int64? {
        get {
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            return appDelegate.accountId
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // only redirect to the create view one time.
        if let acctId = accountId {
        } else {
            goToLogin()
        }
    }
    
    let regionRadius: CLLocationDistance = 2000000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        ParseClient.sharedInstance().getStudentLocations() { JSONResult, error in
            if let error = error {
                println("error?")
                // showAlert, copy from LoginView
            } else {
                if let results = JSONResult.valueForKey("results") as? [[String : AnyObject]] {
                    let studentInfoStructs = results.map {
                        (var dict) -> StudentInformation in
                        return StudentInformation(dict: dict)
                    }
                    
                    let object = UIApplication.sharedApplication().delegate
                    let appDelegate = object as! AppDelegate
                    appDelegate.studentInformationDicts = studentInfoStructs
                    
                    // dispatch_async ensures that the pins display on load
                    dispatch_async(dispatch_get_main_queue(), {
                        self.mapView.addAnnotations(studentInfoStructs.map {
                            (var studentInfo) -> StudentInfoAnnotation in
                            
                            return StudentInfoAnnotation(studentInfo: studentInfo)
                        })
                    })
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // goes to the create meme view
    internal func goToLogin() {
        var loginView = self.storyboard!.instantiateViewControllerWithIdentifier("loginView") as! LoginController
        self.presentViewController(loginView, animated: false, completion: nil)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? StudentInfoAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
    
    // open the link in the subtitle
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let annotation = view.annotation as! StudentInfoAnnotation
        UIApplication.sharedApplication().openURL(NSURL(string: annotation.subtitle)!)
    }
}