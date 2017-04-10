//
//  AddCareTakerViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/2/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class AddCareTakerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let URL_SAVE_TEAM = "https://njati.000webhostapp.com/iRent/add_caretaker.php"
    
    @IBOutlet weak var careTakerIdNumber: UITextField!
    @IBOutlet weak var careTakerFullName: UITextField!
    @IBOutlet weak var careTakerPhoneNumber: UITextField!
    @IBOutlet weak var careTakerEmailAddress: UITextField!
    @IBOutlet weak var careTakerPassword: UITextField!
    @IBOutlet weak var careTakerConfirmPassword: UITextField!
    
    @IBAction func insertCareTaker(_ sender: UIButton) {
        //created NSURL
        let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let national_id_number = self.careTakerIdNumber.text
        let full_name = self.careTakerFullName.text
        let phone_number = self.careTakerPhoneNumber.text
        let email_address = self.careTakerEmailAddress.text
        let password = self.careTakerPassword.text
        
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "national_id_number="+national_id_number!+"&full_name="+full_name!+"&phone_number="+phone_number!+"&email_address="+email_address!+"&password="+password!;
        
        //adding the parameters to request body
        request.httpBody = postParameters.data(using: String.Encoding.utf8)
        
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error)")
                return;
            }
            
            //parsing the response
            do {
                //converting resonse to NSDictionary
                let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                //parsing the json
                if let parseJSON = myJSON {
                    
                    //creating a string
                    var msg : String!
                    
                    //getting the json response
                    msg = parseJSON["message"] as! String?
                    
                    //printing the response
                    print(msg)
                    
                }
            } catch {
                print(error)
            }
            
        }
        //executing the task
        task.resume()
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
