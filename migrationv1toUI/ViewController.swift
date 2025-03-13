//
//  ViewController.swift
//  migrationv1toUI
//
//  Created by Bedri Doğan on 20.01.2025.
//

import UIKit
import AmaniUI
import AmaniSDK

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

    customer = CustomerRequestModel(idCardNumber: "TC_NO")
    
      // Initialize SDK
    guard let customerModel = customer else { return }
    let amaniSDK = AmaniUI.sharedInstance
      // Configure SDK
    amaniSDK.setDelegate(delegate: self)
    
    amaniSDK.set(server: "Server_URL", token: "Token", customer: customer!, apiVersion: .v1)
    /*
     if dont want to use location permissions please provide with useGeoLocation parameter
     amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false)
     
     select showing language with language parameter
     amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,language: "tr")
     
     
     amaniSDK.set(server: "SERVER_URL", token: "TOKEN", customer: customer,useGeoLocation: false,language: "tr")
     */
      // Start SDK
  
      
   
    DispatchQueue.main.async {
     amaniSDK.showSDK(on: self) { customerResponse, error in
        debugPrint(customerResponse)
        debugPrint(error)
      }
    }
    
  }

}

extension ViewController:AmaniUIDelegate{
  func onKYCSuccess(CustomerId: String) {
    debugPrint(CustomerId)
  }
  
  func onKYCFailed(CustomerId: String, Rules: [[String : String]]?) {
    debugPrint(CustomerId, Rules)
  }
  
  func onError(type: String, Error: [AmaniSDK.AmaniError]) {
    debugPrint(type, Error)
  }
  

}
