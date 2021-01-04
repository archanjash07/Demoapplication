//
//  Constants.swift
//  Pedometer
//
//  Created by DebasmitaArchan on 02/07/18.
//  Copyright © 2018 MAC2. All rights reserved.
//

import Foundation
import UIKit

var AUTHKEY = "FTN20190211_BU93HBVF0"
public let LoginScreenStatusColor = UIColorRGBA(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)
public let ScreenRedColor = UIColorRGB(red: 255.0, green: 0.0, blue: 0.0)
public let ScreenBlueColor = UIColorRGB(red: 13.0, green: 89.0, blue: 180.0)
public let ScreenGrayColor = UIColorRGB(red: 114.0, green: 118.0, blue: 114.0)
public let screenWidth = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height
public var myProfileContent : [String:Any]? = nil

struct APIError: Error {
    var errorCode: Int?
    var errorDetails: String?
}

var lifeTimeSteps : String! = "0"
var lifeDistances : String! = "0"
var Total7daysSteps : String! = "0"
var Total7daysDistances : String! = "0"
var Avergae7dayStep : String! = "0"
var Average7dayDistance : String! = "0"
var TotalmonthStep : String! = "0"
var AveragemonthStep: String! = "0"
var kcal = Double()
var co2 = Double()
var liter = Double()
var dollar = Double()
var extralife = Double()
var totaldistance = Double()

struct Section {
    
    var name: String!
    var items: [String]!
    var images: [String]!
    var text : [String]!
    
    init(name: String?, items: [String], images: [String], text: [String]) {
        
        self.name = name
        self.items = items
        self.images = images
        self.text = text
        
    }
}


func setAddress(withaddress address:[String:Any]) {
    if address.isEmpty == false {
//        strApt = address["apartment"] as! String
//        strCity = address["city"] as! String
//        strCountry = address["country"] as! String
//        strLocation = address["location"] as! String
//        strPhone = address["phone"] as! String
//        strState = address["state"] as! String
//        strstreet = address["street"] as! String
//        strZip = address["zip"] as! String
        
    }
}
extension UITextField {
    func placeholderColor(color: UIColor) {
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(0.6),
            NSAttributedString.Key.font: self.font!
            ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
}


func changeStatusbar(withviewcontroller vc:UIViewController){
    if #available(iOS 13.0, *) {
        let app = UIApplication.shared
        let statusBarHeight: CGFloat = app.statusBarFrame.size.height
        
        let statusbarView = UIView()
        statusbarView.backgroundColor = ScreenRedColor
        vc.view.addSubview(statusbarView)
      
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        statusbarView.heightAnchor
            .constraint(equalToConstant: statusBarHeight).isActive = true
        statusbarView.widthAnchor
            .constraint(equalTo: vc.view.widthAnchor, multiplier: 1.0).isActive = true
        statusbarView.topAnchor
            .constraint(equalTo: vc.view.topAnchor).isActive = true
        statusbarView.centerXAnchor
            .constraint(equalTo: vc.view.centerXAnchor).isActive = true
      
    } else {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = ScreenRedColor
    }
}
