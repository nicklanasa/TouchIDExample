//
//  ViewController.swift
//  SampleTouchID
//
//  Created by Nick Lanasa on 2/16/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doItPressed(sender: AnyObject) {
        self.authenicate()
    }
    
    func authenicate() {
        let context = LAContext()
        var error: NSError?
        let localizedString = "Please authenicate with Touch ID to login."
        
        if context.canEvaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.DeviceOwnerAuthenticationWithBiometrics, localizedReason: localizedString, reply: { (success, authError) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if success {
                        UIAlertView(title: "Success!!!",
                            message: "Boom!!!",
                            delegate: self,
                            cancelButtonTitle: "Ok").show()
                    } else {
                        UIAlertView(title: "Error!",
                            message: "Unable to evaluate policy.",
                            delegate: self,
                            cancelButtonTitle: "Ok").show()
                    }
                })
            })
        } else {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIAlertView(title: "Error!",
                    message: "Unable to authenicate with Touch ID.",
                    delegate: self,
                    cancelButtonTitle: "Ok").show()
            })
        }
    }

}

