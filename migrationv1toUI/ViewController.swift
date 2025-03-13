//
//  ViewController.swift
//  migrationv1toUI
//
//  Created by Bedri Doğan on 20.01.2025.
//

import UIKit
import Amani

class ViewController: UIViewController {
  var customer:CustomerRequestModel?
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setInit()
  }
  
  private func setInit() {

    customer = CustomerRequestModel(idCardNumber: "TC_NUM")
    
      // Initialize SDK
    guard let customerModel = customer else { return }
    let amaniSDK = AmaniSDK.sharedInstance
      // Configure SDK
    amaniSDK.setDelegate(delegate: self)
    
    amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer!)
    /*
     if dont want to use location permissions please provide with useGeoLocation parameter
     amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false)
     
     select showing language with language parameter
     amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,language: "tr")
     
     
     amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false,language: "tr")
     */
      // Start SDK
    DispatchQueue.main.async {
      amaniSDK.showSDK(overParent: self)
    }
   
  }

}

extension ViewController:AmaniSDKDelegate{
  func onConnectionError(error: String?) {
      //do whatever when connection error
  }
  func onNoInternetConnection() {
      //do whatever when no internet connection
  }
  func onEvent(name: String, Parameters: [String]?, type: String) {
    /*
     //type // Type returns list of EventType
     //name // Amani Event Name. If there is more than one document,
     returns the type of that document group else returns the type of the document
     (the document type returns to you according to Amani standards).
     
     //parameter // Parameter returns Response, Error of upload.
     If there is available it shows which step (like "0" front, "1" back)
     (log: "XXX_SG_0", ["Continuebtn","0"], "buttonpressed" )
     */
    print("log : \(name), \(Parameters), \(type)")
  }
  func onKYCSuccess(CustomerId: Int) {
      //do whatever when customer approved
  }
  
  func onKYCFailed(CustomerId: Int, Rules: [[String : String]]?) {
      // Returns uncompleted fields
  }
  
  func onTokenExpired() {
      // returns when token expired. Token needs to be refreshed and restart instance
  }
}
