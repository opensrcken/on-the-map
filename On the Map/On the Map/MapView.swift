//
//  MapView.swift
//  On the Map
//
//  Created by Ken Hahn on 5/23/15.
//  Copyright (c) 2015 Ken Hahn. All rights reserved.
//

import UIKit
import MapKit

class MapView : UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
}