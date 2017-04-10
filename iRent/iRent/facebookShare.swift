//
//  facebookShare.swift
//  iRent
//
//  Created by Edwin Eddy Mukenya on 4/5/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKShareKit
import UIKit

let fbTools = facebookShare();

class facebookShare  {
    
    var imageView : UIImageView!
    var label : UILabel!
    var imagePost : UIImage!
    var imageViewPost : UIImageView!
    var postButtonMsg : UIButton!
    var postButtonPhoto : UIButton!

    let LoginButton:FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        button.publishPermissions = ["publish_actions"]
        return button
    }()
   
    
  
    func loginButtonWillLogin(_ LoginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("didCompleteWithResult")
        
        getFacebookUserInfo()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
        imageView.image = UIImage(named: "fb-art.jpg")
        label.text = "Not Logged In"
        buttonEnable(enable: false)
    }
    
    func getFacebookUserInfo() {
        
         let parameters = ["fields":"id,name,email,first_name,last_name,picture.type(large)"]
        if(FBSDKAccessToken.current() != nil)
        {
            
            buttonEnable(enable: true)
            
            //print permissions, such as public_profile
           print(FBSDKAccessToken.current().permissions)
            
           FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) -> Void in
                
                if error != nil{
                    return
                }
                guard let data = result as? [String:Any] else { return }
                self.label.text = data["name"] as? String
            
                if let picture = (result as? NSDictionary)?["picture"] as? NSDictionary,let data = picture["data"] as? NSDictionary,let url = data["url"] as? String {
                   self.imageView.image = self.getProfPic(fid: url)}
            })
        } else {
            buttonEnable(enable: false)
        }
    }
    
    func getProfPic(fid: String) -> UIImage? {
        if (fid != "") {
            let imgURLString = fid
            let imgURL = NSURL(string: imgURLString)
            let imageData = NSData(contentsOf: imgURL! as URL)
            let image = UIImage(data: imageData! as Data)
            return image
        }
        return nil
    }


    
    
    func buttonEnable(enable: Bool) {
        if enable {
            postButtonMsg.alpha = 1
            postButtonMsg.isEnabled = true
            postButtonPhoto.alpha = 1
            postButtonPhoto.isEnabled = true
            imageViewPost.alpha = 1
        } else {
            //postButtonMsg.alpha = 0.3
            //postButtonMsg.isEnabled = false
            //postButtonPhoto.alpha = 0.3
            //postButtonPhoto.isEnabled = false
            //imageViewPost.alpha = 0.3
        }
    }
    
    func btnPostMsg(sender: UIButton) {
        
        if FBSDKAccessToken.current().hasGranted("publish_actions") {
            
            FBSDKGraphRequest.init(graphPath: "me/feed", parameters: ["message" : "Posted with FBSDK Graph API."], httpMethod: "POST").start(completionHandler: { (connection, result, error) -> Void in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    self.alertShow(typeStr: "Message")
                }
            })
        } else {
            print("require publish_actions permissions")
        }
    }
    
    func btnPostPhoto(sender: UIButton) {
        if FBSDKAccessToken.current().hasGranted("publish_actions") {
            let content = FBSDKSharePhotoContent()
            content.photos = [FBSDKSharePhoto(image: imagePost, userGenerated: true)]
            FBSDKShareAPI.share(with: content, delegate: self as! FBSDKSharingDelegate)
        } else {
            print("require publish_actions permissions")
        }
    }
    
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print("didFailWithError")
        alertShow(typeStr: "Photo")
        
    }
    
    public func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
    
    public func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print("didCompleteWithResults")
        alertShow(typeStr: "Photo")
        
    }
    
    
    func alertShow(typeStr: String) {
        let alertController = UIAlertController(title: "", message: typeStr+" Posted!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
       // (self as! UIViewController).present(alertController, animated: true, completion: nil)
    }
    
}
