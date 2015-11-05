//
//  ViewController.swift
//  OAuth Example
//
//  Created by Yannick Weiss on 05/11/15.
//  Copyright © 2015 Yannick Weiss. All rights reserved.
//

import UIKit
import GCDWebServers

class ViewController: UIViewController, GCDWebServerDelegate {
  
  let webServer = GCDWebServer()

  @IBOutlet weak var instructionLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    webServer.delegate = self
    webServer.startWithPort(8080, bonjourName: "appletv")
  }
  
  func webServerDidCompleteBonjourRegistration(server: GCDWebServer!) {
    print("Visit \(webServer.bonjourServerURL) in your web browser")
    instructionLabel.text = "Please Visit \(webServer.bonjourServerURL!.absoluteString) on another device and log in with your account."
    requestToken()
  }
  
  func requestToken() {
    let oauthswift = OAuth1Swift(
      consumerKey:    "5rqqWDzRnfXpvvbmP6qKw",
      consumerSecret: "LQbFp6O9niW1MlMr76CKqNHeJbAjzmyRwk2mbbq0",
      requestTokenUrl: "http://www.goodreads.com/oauth/request_token",
      authorizeUrl:    "http://www.goodreads.com/oauth/authorize",
      accessTokenUrl:  ""
    )
    
    let callbackURL = NSURL(string:"http://chobit.local:8080/")
    oauthswift.postOAuthRequestTokenWithCallbackURL(callbackURL!, success: { (credential, response) -> Void in
      self.registerRedirect(credential.oauth_token)
      }) { (error) -> Void in
        print("Error: ", error)
    }
  }
  
  func registerRedirect(token: String) {
    let webserver = webServer.bonjourServerURL //NSURL(string: "http://chobit.local:8080/")
    let authURL = "http://www.goodreads.com/oauth/authorize?oauth_callback=" + webserver!.absoluteString + "goodreads_oauth_callback&mobile=1&oauth_token=" + token
    
    // redirect / to auth page
    webServer.addDefaultHandlerForMethod("GET", requestClass: GCDWebServerRequest.self, processBlock: {request in
      return GCDWebServerDataResponse(HTML:"<html><body><p>Nothing here!</p></body></html>")
    })
    
    webServer.addHandlerForMethod("GET", path: "/", requestClass: GCDWebServerRequest.self, processBlock: {request in
      return GCDWebServerDataResponse(redirect: NSURL(string: authURL), permanent: true)
      }
    )
    
    // parse /goodreads_oauth_callback
    webServer.addHandlerForMethod("GET", path: "/goodreads_oauth_callback", requestClass: GCDWebServerRequest.self, processBlock: {request in
      
      let oauthToken = request.query["oauth_token"] as! String
      let success = request.query["authorize"] as! String
      if (success == "1") {
        dispatch_async(dispatch_get_main_queue(),{
          self.instructionLabel.text = "Thank you for logging in. " + oauthToken
        })
        return GCDWebServerDataResponse(HTML:"<html><body><p>Thank you for logging in, you can now use the Apple TV</p></body></html>")
      } else {
        dispatch_async(dispatch_get_main_queue(),{
          self.instructionLabel.text = "I am sorry there was an error."
        })
        return GCDWebServerDataResponse(HTML:"<html><body><p>I am sorry it did not work.</p></body></html>")
      }
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

