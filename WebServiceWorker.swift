//
//  WebServiceWorker.swift
//  jsonsatadard
//
//  Created by Dol2omo on 3/30/2560 BE.
//  Copyright © 2560 Dol2omo. All rights reserved.
//

import UIKit

protocol WebServiceWorkerdelegate {
    
}

class WebServiceWorker: NSObject {
    
    var delegate:WebServiceWorkerdelegate?
    
    
    
    func requestMethodservice(Requestmesthod:String ,URLString:String ,Parameters:Dictionary<String,String> ,isAuthorization:Bool) {
        if Requestmesthod.isEmpty == false && URLString.isEmpty == false {

            
            
            var request = URLRequest(url:URL(string:URLString)!)
            request.timeoutInterval = 20
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            if isAuthorization {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            }
            
            
            if Requestmesthod == "POST" {
                request.httpMethod = "POST"


                var bodyData = ""
                for (value,key) in Parameters{
                    
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
                        print("error=\(error)")
                        self.requestFailedWithOperation(error:error)
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                    }
                    else{
                        let responseString = String(data: data, encoding: .utf8)
                        print("responseString = \(responseString)")
                    
                        self.requestFinishedWithJSON(data: data)
                    }
                })
                task.resume()
            }
            
            else if Requestmesthod == "GET" {
                URLSession.shared.dataTask(with: request){datas ,response, error in
                    guard let data = datas, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(error)")
                        self.requestFailedWithOperation(error:error)
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                    }
                    
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(responseString)")
                    
                    self.requestFinishedWithJSON(data: data)
                }

            }
        }
    }
    
    
    func requestWithMethod(requestMethod:String ,urlString:String){
        let params:[String:String]? = nil
        self.requestMethodservice(Requestmesthod: requestMethod, URLString: urlString, Parameters: params!, isAuthorization: false)
    }
    
    func requestWithMethod(requestMethod:String ,urlString:String ,Parameter:[String:String]) {
        self.requestMethodservice(Requestmesthod: requestMethod, URLString: urlString, Parameters: Parameter, isAuthorization: false)
    }
    
    //=========================== requestjsonservice userrequest =============================//
    
    static func requestservice(){
        let params = [book_id:"book_id" ,user_id:"user_id" , "ios":"ios" ,"1245asdasdasdsda":"mac_address"]
        self.requestWithMethod(requestMethod: "GET", urlString: "https://jsonplaceholder.typicode.com/posts/1")
    }
    
    //=============================== dataresponsejsonservice ================================//
    
    func requestFailedWithOperation(error:Error?){
        
    }
    
    func requestFinishedWithJSON(data:Any){
        
        
        print("successjson\(String(data: data as! Data, encoding: .utf8))")
    }
    
    
    

}
