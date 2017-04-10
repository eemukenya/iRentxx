//
//  InsertTenantViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class InsertTenantViewController: UIViewController {
   
    @IBOutlet weak var id_number: UITextField!
    @IBOutlet weak var full_name: UITextField!
    @IBOutlet weak var phone_number: UITextField!
    @IBOutlet weak var house_number: UITextField!
    
    
    @IBAction func insertTenant(_ sender: UIButton) {
        
        //getting values from text fields
        let id_number = self.id_number.text
        let full_name = self.full_name.text
        let phone_number = self.phone_number.text
        let house_number = self.house_number.text
        
        
    
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "id_number="+id_number!+"&full_name="+full_name!+"&phone_number="+phone_number!+"&house_number="+house_number!+"&tenancy_staus=LIVING IN&lease_type=RESIDENTIAL";
        
        
        var request = URLRequest(url: URL(string: "https://njati.000webhostapp.com/iRent/add_tenant.php")!)
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
        let alert = UIAlertController(title: "Success", message: "Data inserted successfully. Press back to view data", preferredStyle: UIAlertControllerStyle.alert)
        
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
    
    @IBAction func clearButton(_ sender: UIButton) {
        self.id_number.text = "";
        self.full_name.text = "";
        self.phone_number.text = "";
        self.house_number.text = "";
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
