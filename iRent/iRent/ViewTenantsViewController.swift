//
//  ViewController.swift
//  JOSNSwiftDemo
//
//  Created by Shinkangsan on 12/5/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit

class ViewTenantsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            webView.loadRequest(NSURLRequest(url: NSURL(string: "https://njati.000webhostapp.com/iRent/view_tenants.php")! as URL) as URLRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

