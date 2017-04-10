//
//  TenantCreateAccountViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/7/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class TenantCreateAccountViewController: UIViewController {

    @IBOutlet weak var id_number: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confPassword: UITextField!
    
    @IBAction func insertTenantView(_ sender: UIButton) {
        //getting values from text fields
        let id_number = self.id_number.text
        let password = self.password.text
        let confPassword = self.confPassword.text
       
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "id_number="+id_number!+"&password="+password!;

        if(password! == confPassword!){
            var request = URLRequest(url: URL(string: "https://njati.000webhostapp.com/iRent/tenant_create_account.php")!)
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
            let alert = UIAlertController(title: "Success", message: "Data inserted successfully. Press back to login", preferredStyle: UIAlertControllerStyle.alert)
            
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
        self.id_number.text = ""
        self.password.text = ""
        self.confPassword.text = ""
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
