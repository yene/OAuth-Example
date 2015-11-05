//
//  ViewController.swift
//  OAuth Example
//
//  Created by Yannick Weiss on 05/11/15.
//  Copyright © 2015 Yannick Weiss. All rights reserved.
//

import UIKit
import GCDWebServers

class ViewController: UIViewController {

  @IBOutlet weak var instructionLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    let webServer = GCDWebServer()
    
    /*
    docs https://www.goodreads.com/api/documentation#oauth
    
    1. request Goodreads for a request token.

    2. redirect user to
    http://www.goodreads.com/oauth/authorize?oauth_callback=http://chobit.local:8080/goodreads_oauth_callback&mobile=1&oauth_token=
    

    3. goodreads will give me the following request
    http://yourapp.com/goodreads_oauth_callback?oauth_token=ezBHZc7C1SwvLGc646PEQ&authorize=1

*/
    
    webServer.addDefaultHandlerForMethod("GET", requestClass: GCDWebServerRequest.self, processBlock: {request in
      return GCDWebServerDataResponse(HTML:"<html><body><p>Hello World</p></body></html>")
      
    })
  
    webServer.startWithPort(8080, bonjourName: "appletv")
    
    // Todo put into a callback
    instructionLabel.text = "Please Visit http://chobit.local:8080/ on another device and log in with your account."
    print("Visit \(webServer.serverURL) in your web browser")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

