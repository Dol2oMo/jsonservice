//
//  WebserviceManager.swift
//  jsonsatadard
//
//  Created by Dol2omo on 3/30/2560 BE.
//  Copyright © 2560 Dol2omo. All rights reserved.
//

import UIKit


class WebserviceManager: NSObject,WebServiceWorkerdelegate {
    
//    var pendingWorker = NSMutableSet()

    static let sharedInstance = WebserviceManager()
    
//    override init() {
//        pendingWorker = NSMutableSet()
//    }
    
    
    
    func workerWithDelegate(delegate_:Any) -> WebServiceWorker {
        

        let webservice = WebServiceWorker.init()
        webservice.delegates = self
        webservice.requestClassDelegate = delegate_ as? WebServiceWorkerdelegate
        
        
//        pendingWorker.add(_:delegate_)
        
        
        return webservice
        
    }
    
//    func requestClassDelegateFromWorker(worker:Any) -> Any? {
//        
//        
//        let stillPendingWorker = pendingWorker .member(worker)
//        
//        
//        return stillPendingWorker
//    }

    
    
    func getprovince(delegate delegate_:Any){
        
        
        
        
        let webserviceworker:WebServiceWorker =  self.workerWithDelegate(delegate_: delegate_)
        
        webserviceworker.getprovince()
        
    }
    
    

    
    func finishedWorker(worker: WebServiceWorker, result: AnyObject) {
        
        let requestclass:WebServiceWorkerdelegate = worker.requestClassDelegate!
        
        
        
        requestclass.finishedWorker!(worker: worker, result: result)
        

    }
    
    
    
    
    

}


