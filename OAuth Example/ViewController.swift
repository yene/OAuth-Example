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

  override func viewDidLoad() {
    super.viewDidLoad()
    let webServer = GCDWebServer()
    
    webServer.addDefaultHandlerForMethod("GET", requestClass: GCDWebServerRequest.self, processBlock: {request in
      return GCDWebServerDataResponse(HTML:"<html><body><p>Hello World</p></body></html>")
      
    })
  
    webServer.startWithPort(8080, bonjourName: "GCD Web Server")
    
    print("Visit \(webServer.serverURL) in your web browser")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

