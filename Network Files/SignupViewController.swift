//
//  SignupViewController.swift
//  The Flying Lemon
//
//  Created by Devanshu on 12/07/18.
//  Copyright © 2018 Devanshu. All rights reserved.
//

import Foundation
import WebKit
import AVFoundation

class SignupViewController: UIViewController {
    
    @IBOutlet weak var signupView: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
                
        // Signup URL
        
        let signupURL = URL(string: "https://appleid.apple.com/account")
        
        let request = URLRequest(url: signupURL!)
        
        signupView.load(request)
        
    }
    
}
