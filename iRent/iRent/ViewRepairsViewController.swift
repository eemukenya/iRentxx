//
//  ViewRepairsViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class ViewRepairsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL (string: "https://njati.000webhostapp.com/iRent/view_repairs.php");
        let request = NSURLRequest(url: url! as URL);
        webView.loadRequest(request as URLRequest);
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
