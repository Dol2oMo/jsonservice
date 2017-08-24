//
//  ViewController.swift
//  jsonsatadard
//
//  Created by Dol2omo on 3/30/2560 BE.
//  Copyright © 2560 Dol2omo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var provincebutton:UIButton?
    let webworker = WebserviceManager()
    let viewselectaddress:UIView = {
       let viewaddress = UIView()
        viewaddress.backgroundColor = UIColor.lightGray.withAlphaComponent(0.8)
        viewaddress.translatesAutoresizingMaskIntoConstraints = false
        return viewaddress
    }()
    let tableview:UITableView = {
       var tableviewaddress = UITableView()
        tableviewaddress = UITableView(frame: tableviewaddress.frame, style: .grouped)
        tableviewaddress.translatesAutoresizingMaskIntoConstraints = false
        
        return tableviewaddress
        
    }()
    
    let cancelbutton:UIButton = {
       var button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.textColor = UIColor.white
//        button.backgroundColor = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        button.backgroundColor = UIColor.brown
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        provincebutton?.addTarget(self, action: #selector(self.selectprovince(sender:)), for: .touchUpInside)
        cancelbutton.addTarget(self, action: #selector(self.cancelselectaddressview), for: .touchUpInside)
        
        webworker.getprovince(delegate: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    func selectprovince(sender:UIButton){
//        webworker.getprovince(delegate: self)
//        
//    }
    
    func cancelselectaddressview(){
        self.tableview.removeFromSuperview()
        self.viewselectaddress.removeFromSuperview()
    }
    
    
    func setupViewaddress(){
        
        viewselectaddress.addSubview(tableview)
        viewselectaddress.addSubview(cancelbutton)
        self.view.addSubview(viewselectaddress)
        
        self.view.addconstraintsWithFormat(format: "H:|[viewselectaddress]|", views: ["viewselectaddress":viewselectaddress])
        self.view.addconstraintsWithFormat(format: "V:|[viewselectaddress]|", views: ["viewselectaddress":viewselectaddress])
        
        self.viewselectaddress.addconstraintsWithFormat(format: "H:|-20-[tableview]-20-|", views: ["tableview":tableview])
        self.viewselectaddress.addconstraintsWithFormat(format: "H:|-60-[cancelbutton]-60-|", views: ["cancelbutton":cancelbutton])
        self.viewselectaddress.addconstraintsWithFormat(format: "V:|-20-[tableview]-8-[cancelbutton(40)]-20-|", views: ["tableview":tableview,"cancelbutton":cancelbutton])

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}



extension ViewController:WebServiceWorkerdelegate{
    func finishedWorker(worker: WebServiceWorker, result: AnyObject){
        
        if worker.mode == .contenprovince  {
            let data = result.object(forKey: "data") as! NSArray
  
            print("result:\(data[1])")
            DispatchQueue.main.async(execute: { () -> Void in
                self.setupViewaddress()
            })
        }
        
        
        
        
    }
}






