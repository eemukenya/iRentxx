//
//  InsertCaretakerViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class InsertCaretakerViewController: UIViewController {

    let URL_SAVE_TEAM = "https://njati.000webhostapp.com/iRent/add_caretaker.php"
   
    @IBOutlet weak var careTakerIdNumber: UITextField!
    @IBOutlet weak var careTakerFullName: UITextField!
    @IBOutlet weak var careTakerPhoneNumber: UITextField!
    @IBOutlet weak var careTakerEmailAddress: UITextField!
    @IBOutlet weak var careTakerPassword: UITextField!
    @IBOutlet weak var careTakerConfirmPassword: UITextField!
    
    
    @IBAction func insertCareTaker(_ sender: UIButton) {
        
        //getting values from text fields
        let national_id_number = self.careTakerIdNumber.text
        let full_name = self.careTakerFullName.text
        let phone_number = self.careTakerPhoneNumber.text
        let email_address = self.careTakerEmailAddress.text
        let password = self.careTakerPassword.text
        
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "national_id_number="+national_id_number!+"&full_name="+full_name!+"&phone_number="+phone_number!+"&email_address="+email_address!+"&password="+password!;
        
        
        var request = URLRequest(url: URL(string: "https://njati.000webhostapp.com/iRent/add_caretaker.php")!)
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
