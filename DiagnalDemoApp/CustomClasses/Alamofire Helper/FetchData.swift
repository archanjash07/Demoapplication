//
//  FetchData.swift
//  DemoApp
//
//  Created by DemoApp on 05/03/18.
//  Copyright © 2018 DemoApp. All rights reserved.
//

import Foundation
import Reachability

import Alamofire
class FetchData {
    static func BaseApiCalling(withurlString urlString: String , withjsonString parameters: Parameters,withloaderMessage loaderMessage:String, withSuccess success:@escaping (_ response: (Any)) -> Void, andFailure failure:@escaping (_ error: Error?) -> Void) {
       
       
        let reachability = try! Reachability()

        if reachability.connection != .none {
            print("Main url==\(urlString)")
            //print("Parameters==\(parameters)")
            
            Alamofire.request(urlString, method:.post, parameters:parameters, encoding: URLEncoding.default).responseJSON{ response in
                
                let json = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                if let jsonResponse = json{
                   // print("response json : \(jsonResponse)")
                  //  SVProgressHUD.dismiss()
                }
                
                let jsonStr = String.init(data: response.data!, encoding: String.Encoding.utf8)
                if let errorStr = jsonStr{
                  //  print("response str : \(errorStr)")
                 //   SVProgressHUD.dismiss()
                    success(errorStr)
                }
                
              
                if (response.error != nil) {
                     print("ERRROR")
                    let error = APIError(errorCode: -201, errorDetails: response.error!.localizedDescription)
                    print(error)
                    
                  //   SVProgressHUD.showError(withStatus: response.error!.localizedDescription)
                    failure (error)
                    
                } else {
                    
                    let result =  response.result.value
                    let statusCode = response.response?.statusCode
                    print("StatusCode= \(statusCode!)")
                    
                    if (statusCode == 200)
                    {
                     //  SVProgressHUD.dismiss()
                          print("SUUCCESSS")
                        success(result!)
                        
                    }
                    else
                    {
                     //   SVProgressHUD.dismiss()
                        print("ERRROR")
                        let error = APIError(errorCode: -202, errorDetails: "api failure")
                                            failure (response.result.error)
                      //   SVProgressHUD.showError(withStatus: response.error!.localizedDescription)
                        failure (error)
                    }
                    
                }//response else
                
            }//ALamofire
        }
        reachability.whenUnreachable = { _ in
            
            let error = APIError(errorCode: -200, errorDetails: "No network")
          //  SVProgressHUD.showError(withStatus: "No internet connection")
            failure(error)
        }
    }
    
    static func GetMethodBaseApiCalling(withurlString urlString: String, withSuccess success:@escaping (_ response: (Any)) -> Void, andFailure failure:@escaping (_ error: Error?) -> Void) {
      //  SVProgressHUD.show()
        let reachability = try! Reachability()

        if reachability.connection != .none {
//            SDLoaderConfiguration.loaderConfig()
//            SDLoaderConfiguration.sdLoader.startAnimating(atView: (UIApplication.shared.windows.first)!)
            
            print("Main url==\(urlString)")
            
            Alamofire.request(urlString, method:.get, encoding: URLEncoding.default).responseJSON{ response in
                
                let json = try? JSONSerialization.jsonObject(with: response.data!, options: [])
                if let jsonResponse = json{
                    print("response json : \(jsonResponse)")
                  //  SVProgressHUD.dismiss()
                }
                
                let jsonStr = String.init(data: response.data!, encoding: String.Encoding.utf8)
                if let errorStr = jsonStr{
                    print("response str : \(errorStr)")
                //    SVProgressHUD.dismiss()
                }
                
                //SDLoaderConfiguration.sdLoader.stopAnimation()
                
                if (response.error != nil) {
                  //  SVProgressHUD.dismiss()
                    let error = APIError(errorCode: -201, errorDetails: response.error!.localizedDescription)
                    failure (error)
                    print("eerroorr==\(response.error!.localizedDescription)")
                    
                    
                } else {
                   
                    let result =  response.result.value
                    print("*******\(String(describing: result!))")
                    let statusCode = response.response?.statusCode
                    print("StatusCode= \(statusCode!)")
                    
                    if (statusCode == 200)
                    {
                     //   SVProgressHUD.dismiss()
                        success(result!)
                    }
                    else
                    {
                 //   SVProgressHUD.dismiss()
                    let error = APIError(errorCode: -202, errorDetails: "api failure")
                        failure (error)
                    }
                    
                }//response else
                
            }//ALamofire
        } else {
          //  SVProgressHUD.dismiss()
            let error = APIError(errorCode: -200, errorDetails: "No network")
            failure(error)
        }
        
        
    }

    
    static func requestWithImage(withurlString urlString: String, forImageOne imageDataOne: [String: Any],parameters: [String : Any], withSuccess success:@escaping (_ response: (Any)) -> Void, andFailure failure:@escaping (_ error: APIError?) -> Void) {
        
        let reachability = try! Reachability()

        if reachability.connection != .none {
            print("Main url==\(urlString)")
           // print("Parameters==\(parameters)")
            
            let headers: HTTPHeaders = [
                /* "Authorization": "your_access_token",  in case you need authorization header */
                "Content-type": "multipart/form-data"
            ]
            Alamofire.upload(
                multipartFormData: { (multipartFormData) in
                    for (key, value) in parameters {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    let idproofData = imageDataOne["data"] as? Data
                    let idproofExtension = imageDataOne["extension"] as? String
                    let idproofFileName = "image" + idproofExtension!
                    let idproofMimeType = imageDataOne["mimeType"] as? String
                    print(imageDataOne)
                    let timestamp = NSDate().timeIntervalSince1970
                    let myTimeInterval = TimeInterval(timestamp)
                    let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
                    let filename = (Int(round(timestamp)))
                    if let data_id_proof = idproofData{
                       multipartFormData.append(data_id_proof, withName: "image", fileName: "\(filename)", mimeType: "image/png")
                    }
                }, usingThreshold: UInt64.init(), to: urlString, method: .post, headers: headers) { (result) in
                
                print(result)
                switch result {
                case .success(let upload,_,_ ):
                    upload.uploadProgress(closure: { (progress) in
                        print("Upload Progress: \(progress.fractionCompleted)")
                    })
                    
                    upload.responseJSON { response in
                        switch response.result {
                        case .success(let response):
                            print("json : \(response)")
                            success(response)
                            break
                        case .failure( _):
                            let error = APIError(errorCode: -201, errorDetails: "api failure")
                            failure (error)
                            print("Webservice Error - \(error.localizedDescription)")
                            break
                        }
                        
                    }
                    
                case .failure( _):
                    
                    let error = APIError(errorCode: -201, errorDetails: "api failure")
                    failure (error)
                }
            }
            
        } else {
            let error = APIError(errorCode: -200, errorDetails: "No network")
            failure(error)
        }
        
    }
 
    
    
}




class ApiCall {
    
    
    static func BaseApiCalling(withurlString urlString: String , withjsonString jsonString: String,withloaderMessage loaderMessage:String, withSuccess success:@escaping (_ response: (Any)) -> Void, andFailure failure:@escaping (_ error: Error?) -> Void) {
       // SVProgressHUD.show()
      //  SDLoaderHelper.loaderHelper(withmessage: loaderMessage)
      //  SDLoaderHelper.sdLoader.startAnimating(atView: (UIApplication.shared.windows.first)!)
        print("Min url==\(urlString)")
        print("JSON StRING==\(jsonString)")
        let urlString = urlString
        let json = jsonString
        var result : Any?
        let url = URL(string: urlString)!
        let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        print(jsonData)
        
        
        Alamofire.request(request).responseJSON {
            (response) in
            
            print(response)
            if (response.error != nil)
            {
              //   SVProgressHUD.dismiss()
               // SDLoaderHelper.sdLoader.stopAnimation()
                print("eerroorr==\(response.error!.localizedDescription)")
                failure(response.result.error!)
            }
            else
            {
                result = response.result.value
                
                print("*******\(String(describing: result))")
                
                let statusCode = response.response?.statusCode
                
                print("StatusCode= \(statusCode!)")
                
                if (statusCode == 200)
                {
                    // SVProgressHUD.dismiss()
                 //   SDLoaderHelper.sdLoader.stopAnimation()
                    //print("Success")
                    print("RESULT== \(result)")
                    success (result)
                    //return  response.result.value
                }else{
                    // SVProgressHUD.dismiss()
                   // SDLoaderHelper.sdLoader.stopAnimation()
                   // print("eerroorr==\(response.error!.localizedDescription)")
                    failure(response.result.error)
                }
            }
            
        }//Alamofire
        
    }
    
    
    static func requestWithImage(withurlString urlString: String, forImageOne imageDataOne: Data?, parameters: [String : Any], withSuccess success:@escaping (_ response: (Any)) -> Void, andFailure failure:@escaping (_ error: Error?) -> Void) {
        
       // SDLoaderHelper.loaderHelper(withmessage: "Loading")
       // SDLoaderHelper.sdLoader.startAnimating(atView: (UIApplication.shared.windows.first)!)
       //  SVProgressHUD.dismiss()
        print("Min url==\(urlString)")
        
      //  print("Parametrss=== \(parameters)")
        
        let headers: HTTPHeaders = [
            
            /* "Authorization": "your_access_token",  in case you need authorization header */
            
            "Content-type": "application/json"
            
        ]
        
        Alamofire.upload(
            multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                if let myimage = imageDataOne{
                    
                    multipartFormData.append(myimage, withName: "Image", fileName: "Image.jpg", mimeType: "image/jpg")
                    
                }
        }, usingThreshold: UInt64.init(), to: urlString, method: .post, headers: headers) { (result) in
            
            
            
            print(result)
            
            
            
            switch result {
                
                
                
            case .success(let upload,_,_ ):
                
                
                
                upload.uploadProgress(closure: { (progress) in
                    
                    print("Upload Progress: \(progress.fractionCompleted)")
                    
                })
                
                
                
                upload.responseJSON { response in
                    
                    
                
                   // SDLoaderHelper.sdLoader.stopAnimation()
                    
                    // SVProgressHUD.dismiss()
                    
                    switch response.result {
                        
                        
                        
                    case .success(let response):
                        
                        
                        
                        print("json : \(response)")
                        
                        success(response)
                        
                        break
                        
                        
                        
                    case .failure(_):
                      //   SVProgressHUD.dismiss()
                     //   SDLoaderHelper.sdLoader.stopAnimation()
                        print("Webservice Error -==\(response.error!.localizedDescription)")
                        failure(response.result.error)
                        
                        
                        
                        break
                        
                    }
                    
                    
                    
                }
                
                
                
            case .failure(let error):
               //  SVProgressHUD.dismiss()
               // SDLoaderHelper.sdLoader.stopAnimation()
                print("eerroorr==\(error.localizedDescription)")
                failure(error)
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
}
