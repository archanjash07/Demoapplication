//
//  ViewController.swift
//  DiagnalDemoApp
//
//  Created by DemoApp on 27/05/20.
//  Copyright © 2020 Demo. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {

    // MARK: - Variables
    
    var name = String()
    var url = String()
    var profileimg = String()
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        GetLoginApiCall()
    }
    
    
   // MARK: - Api Call
    
         func GetLoginApiCall() {
            FetchData.GetMethodBaseApiCalling(withurlString: Urls.mainurl + txtUserName.text!, withSuccess: { (response) in
            print("myresponse")
            
                
                if response is [String: Any] {
                    var dict = [String:Any]()
                  
                    let Main_response = response as! [String: Any]
                    let login = Main_response["login"] as? String
                    let url = Main_response["url"] as? String
                    let avatar_url = Main_response["avatar_url"] as? String
                    self.name = login!
                    self.url = url!
                    self.profileimg = avatar_url!
            UserDefaults.standard.set( login, forKey: "loginid")
                    
                                                 
                                                 let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                                                  secondViewController.gitName = self.name
                                                  secondViewController.gitUrl = self.url
                    secondViewController.gitDp = self.profileimg
                                                        self.navigationController?.pushViewController(secondViewController, animated: true)
                    UserDefaults.standard.set( login, forKey: "loginid")
                  
                    
                }
                
            }) { (error) in
                let str = (String(describing: error!.localizedDescription))
              //  alert(withmessage: str, withpresentviewcontroller: self, withtype: "Single")
                //            AlertViewController.showPopup(onParentViewController: self, withSelectedItem: self.str, withPickerData: "") { (selectedobject, selectedposition) in
                //
                //            }
            }
        }

    }
    


