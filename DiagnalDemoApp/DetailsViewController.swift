//
//  DetailsViewController.swift
//  DiagnalDemoApp
//
//  Created by DemoApp on 02/01/21.
//  Copyright © 2021 Demo. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
class DetailsViewController: UIViewController {
    
    // MARK: - Variables
    
    var arrItems = [Any]()
    var arrCount = [Any]()
    var gitName = String()
    var gitUrl = String()
    var gitDp = String()
   
    @IBOutlet weak var imgPublic: UIImageView!
    @IBOutlet weak var lblPublicUrl: UILabel!
    @IBOutlet weak var lblpublicName: UILabel!
    @IBOutlet weak var tableViewAccount: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetRepoApiCall(withurlString: gitName)
       
        self.lblPublicUrl.text = gitUrl
        self.lblpublicName.text = gitName
        self.lblpublicName.text = gitName
        self.imgPublic.sd_setImage(with: URL(string: gitDp)!, placeholderImage:#imageLiteral(resourceName: "placeholder_for_missing_posters"))
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
     // MARK: - Repo Api Call
    
    func GetRepoApiCall(withurlString urlString: String) {
               FetchData.GetMethodBaseApiCalling(withurlString: Urls.repourl +  urlString + "/repos", withSuccess: { (response) in
               print("myresponse")
               
                   
                   if response is [Any] {
                       var dict = [String:Any]()
                    
                    
                       let data = response as! [Any]
                      if data.count != 0 {
                                for i in 0 ..< data.count {
                                    let dict = data[i]
                                    let dict1 = (dict as!  [String:Any])
                                                    
                        }
                    }
                    self.arrItems = data
                    self.tableViewAccount.reloadData()
                       
                   }
                   
               }) { (error) in
                   let str = (String(describing: error!.localizedDescription))
                 //  alert(withmessage: str, withpresentviewcontroller: self, withtype: "Single")
                   //            AlertViewController.showPopup(onParentViewController: self, withSelectedItem: self.str, withPickerData: "") { (selectedobject, selectedposition) in
                   //
                   //            }
               }
           }

    // MARK: - Commit Api Call
    
    func GetCommitApiCall(withurlString urlString: String,withurlString urlStringname: String) {
               FetchData.GetMethodBaseApiCalling(withurlString: Urls.commiturl +  urlStringname + "/" + urlString + "/commits", withSuccess: { (response) in
               print("myresponse")
               
                   
                   if response is [Any] {
                       var dict = [String:Any]()
                    
                    
                       let data = response as! [Any]
                    
                      if data.count != 0 {
                                for i in 0 ..< data.count {
                                    let dict = data[i]
                                    let dict1 = (dict as!  [String:Any])
                         //   let name = dict1 ["name"] as? String
                        }
                    }
                    
                    self.arrCount = data
                    self.tableViewAccount.reloadData()
                    print("@@@@\(self.arrCount.count)")
                    let alert = UIAlertController(title: "Github", message: "No of commits :\(self.arrCount.count)", preferredStyle: UIAlertController.Style.alert)
                           alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
                           self.present(alert, animated: true, completion: nil)
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
 // MARK: - TableView

private typealias TableViewMethods = DetailsViewController
extension TableViewMethods: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return arrItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewAccount.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
       
       
            cell.lblitemname.text! = (arrItems[indexPath.row] as! [String:Any])["name"] as! String
        if let desc = (arrItems[indexPath.row] as! [String:Any])["description"] as? String {
        cell.lblitemnamedetails.text! = (arrItems[indexPath.row] as! [String:Any])["description"] as! String
        }
        return cell
        
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UserDefaults.standard.set((arrItems[indexPath.row] as! [String:Any])["name"] as! String, forKey: "nameid")
        GetCommitApiCall(withurlString: (arrItems[indexPath.row] as! [String:Any])["name"] as! String, withurlString: gitName)
//        let alert = UIAlertController(title: "Github", message: "No of commits :\(self.arrCount.count)", preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
    }
    
    
}

// MARK: - TableView Cell

class DetailsCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var lblitemname: UILabel!
    @IBOutlet weak var lblitemnamedetails: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
