//
//  TenantChangePasswordViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class TenantChangePasswordViewController: UIViewController {
    @IBOutlet weak var curent_password: UITextField!
    @IBOutlet weak var new_password: UITextField!
    @IBOutlet weak var conf_new_password: UITextField!
    
    @IBAction func changeTenantPassword(_ sender: UIButton) {
        //getting values from text fields
        let curent_password = self.curent_password.text
        let new_password = self.new_password.text
        let conf_new_password = self.conf_new_password.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "password="+curent_password!+"&id_number=12345678";
        
        if(new_password! == conf_new_password!){
            var request = URLRequest(url: URL(string: "https://njati.000webhostapp.com/iRent/tenant_change_password.php")!)
            request.httpMethod = "POST"
            
            
            let postString = postParameters
            request.httpBody = postString.data(using: .utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(error)")
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(response)")
                }
                
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(responseString)")
            }
            let alert = UIAlertController(title: "Success", message: "Password changed successfully.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("cancel")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            task.resume()
        } else {
            let alert = UIAlertController(title: "Error!", message: "Password and password confirmation do not match!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("cancel")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func clearText(_ sender: UIButton) {
        self.curent_password.text = ""
        self.new_password.text = ""
        self.conf_new_password.text = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
