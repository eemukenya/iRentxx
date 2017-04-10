//
//  CaretakerLoginViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class CaretakerLoginViewController: UIViewController {

    @IBOutlet weak var id_number: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login_error: UILabel!
    @IBAction func careTakerLogin(_ sender: UIButton) {
        
        self.login_error.text = "Signing in... Please wait"
        self.login_error.textColor = UIColor.green
        
        //getting values from text fields
        let id_number = self.id_number.text
        let password = self.password.text

        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "id_number="+id_number!+"&password="+password!;
        
        
        var request = URLRequest(url: URL(string: "https://njati.000webhostapp.com/iRent/caretaker_login.php")!)
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
            
            if(responseString == "0"){
                self.login_error.text = "Login Error! Wrong username or password"
                self.login_error.textColor = UIColor.red
            } else {
                self.performSegue(withIdentifier: "moveToCareTakerHome", sender: self)
            }
        }
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "caretakerLoginSuccessful" {
            _ = segue.destination as? ViewTenantsViewController
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Login loaded")
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
