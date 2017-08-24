//
//  WebServiceWorker.swift
//  jsonsatadard
//
//  Created by Dol2omo on 3/30/2560 BE.
//  Copyright © 2560 Dol2omo. All rights reserved.
//

import UIKit

enum ContentWorkerMode {
    case contenprovince
    
}


@objc protocol WebServiceWorkerdelegate:class {
    
    @objc optional func finishedWorker(worker:WebServiceWorker ,result:AnyObject)
    @objc optional func failedWorker(worker:WebServiceWorker ,result:Any)
}

class WebServiceWorker: NSObject {
    
    var delegates:WebServiceWorkerdelegate?
    var requestClassDelegate:WebServiceWorkerdelegate?
    
    
    var mode:ContentWorkerMode?
    
    
    
    
    func requestMethodservice(Requestmesthod:String ,URLString:String ,Parameters:Dictionary<String,String>? ,workerMode:ContentWorkerMode, isAuthorization:Bool) {
        if Requestmesthod.isEmpty == false && URLString.isEmpty == false {
            
            //            var operation  = RequestoperationManag()
            
            mode = workerMode
            
            var request = URLRequest(url:URL(string:URLString)!)
            request.timeoutInterval = 20
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            if isAuthorization {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            }
            
            
            if Requestmesthod == "POST" {
                request.httpMethod = "POST"
                //                let params = ["7542":"book_id" ,"352":"user_id" , "ios":"platform" ,"1245asdasdasdsda":"mac_address"] as NSDictionary
                
                var bodyData = ""
                for (value,key) in Parameters!{
                    
                    if let encodedKey = (key as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                        if let encodedValue = (value as AnyObject).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                            if bodyData == nil
                            {
                                continue
                            }
                            else
                            {
                                if bodyData == "" {
                                    
                                }
                                else{
                                    bodyData += "&"
                                }
                            }
                            bodyData += encodedKey + "=" + encodedValue
                        }
                    }
                }
                
                request.httpBody = bodyData.data(using: .utf8)
                
                
                let task = URLSession.shared.dataTask(with: request, completionHandler: {datas, response, error -> Void in
                    guard let data = datas, error == nil else {                                                // check for fundamental networking error
                        print("error=\(String(describing: error))")
                        self.requestFailedWithOperation(error:error)
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        //                        print("response = \(String(describing: response))")
                    }
                    else{
                        //                        let responseString = String(data: data, encoding: .utf8)
                        //                        print("responseString = \(String(describing: responseString))")
                        
                        self.requestFinishedWithJSON(data: data)
                    }
                })
                task.resume()
            }
                
            else if Requestmesthod == "GET" {
                let task = URLSession.shared.dataTask(with: request, completionHandler: {datas, response, error -> Void in
                    guard let data = datas, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(String(describing: error))")
                        self.requestFailedWithOperation(error:error)
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        //                        print("response = \(String(describing: response))")
                    }
                    else{
                    
                    //                    let responseString = String(data: data, encoding: .utf8)
                    //                    print("responseString = \(String(describing: responseString))")
                    
                    
                    self.requestFinishedWithJSON(data: data)
                    }
                })
                
                task.resume()
                
            }
        }
    }
    
    
    func requestWithMethod(requestMethod:String ,urlString:String ,workerMode:ContentWorkerMode){
        let params:[String:String]? = nil
        self.requestMethodservice(Requestmesthod: requestMethod, URLString: urlString, Parameters: params,workerMode:workerMode , isAuthorization: false)
    }
    
    func requestWithMethod(requestMethod:String ,urlString:String ,Parameter:[String:String] , workerMode:ContentWorkerMode) {
        self.requestMethodservice(Requestmesthod: requestMethod, URLString: urlString, Parameters: Parameter,workerMode: workerMode ,isAuthorization: false)
    }
    
    //=========================== requestjsonservice userrequest =============================//
    
    func getprovince() {
//        let url = "\(webserviceget)?params=get_province"
        requestWithMethod(requestMethod: "GET", urlString:"\(webserviceget)?params=get_province" , workerMode: ContentWorkerMode.contenprovince)
        
    }

    
    //=============================== dataresponsejsonservice ================================//
    
    func requestFailedWithOperation(error:Error?){
        
    }
    
    func requestFinishedWithJSON(data:Any){
        
        var json:Any!
        
        do{
            
            json = try JSONSerialization.jsonObject(with: data as! Data, options: .mutableContainers)
            
            
            
        } catch let jsonerror{
            
            self.requestFailedWithOperation(error: jsonerror)
        }

        if let contenmode = mode{
            switch contenmode {
            case .contenprovince:
                
//                    print("successjson\(String(describing: String(data: data as! Data, encoding: .utf8)))")
                    
//                    var result = finishedrequestwebservice()
//                    result.finishedrequest(result: json)
                
                let webservicemanager = WebserviceManager()
                webservicemanager.finishedWorker(worker: self, result: json as AnyObject)
                
                
                break
                
            default:
                
                print("sadasd")
                
                break
                
            }
        }
        
    }
    
    
    
    
}
