//
//  TenantLoginViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class TenantLoginViewController: UIViewController , FBSDKLoginButtonDelegate, FBSDKSharingDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let buttonx = fbTools.LoginButton
            //buttonx.center = CGPoint(x: view.center.x, y: 260)
            buttonx.delegate = self
            view.addSubview(buttonx)
            buttonx.translatesAutoresizingMaskIntoConstraints = false
            buttonx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
            buttonx.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
    
        var imagex = fbTools.imageView
        imagex = UIImageView(frame: CGRect(x:0,y: 0, width:100, height:100))
        imagex?.center = CGPoint(x: view.center.x, y: 150)
        imagex?.image = UIImage(named: "fb-art.jpg")
       // view.addSubview(imagex!)
        
        
        var labelx=fbTools.label
        labelx = UILabel(frame: CGRect(x:0,y:0,width:200,height:30))
        labelx?.center = CGPoint(x: view.center.x, y: 250)
        labelx?.text = "Not Logged In"
        labelx?.textAlignment = NSTextAlignment.center
        //view.addSubview(labelx!)
        // Do any additional setup after loading the view.
        
        
        var imagePostx = fbTools.imagePost
            imagePostx = UIImage(named: "image.jpg")
        
        var imageViewPostx = fbTools.imageViewPost
        imageViewPostx = UIImageView(frame: CGRect(x:0, y:0, width:100, height:100))
        imageViewPostx?.center = CGPoint(x: view.center.x, y: 400)
        imageViewPostx?.image = imagePostx
        imageViewPostx?.contentMode = UIViewContentMode.scaleAspectFit
        //view.addSubview(imageViewPostx!)
        
        
        var postButtonMsgx = fbTools.postButtonMsg
        postButtonMsgx = UIButton(frame: CGRect(x:0, y:0, width:300, height:30))
        postButtonMsgx?.center = CGPoint(x: view.center.x, y: 440)
        postButtonMsgx?.setTitle("Post a Message", for: UIControlState.normal)
        postButtonMsgx?.setTitleColor(UIColor.blue, for: UIControlState.normal)
        postButtonMsgx?.setTitleColor(UIColor.cyan, for: UIControlState.highlighted)
       // postButtonMsgx?.addTarget(self, action: #selector(fbTools.btnPostMsg(sender:)), for: .touchUpInside)
        postButtonMsgx?.addTarget(self, action: Selector(("fbTools.btnPostMsg:")), for: UIControlEvents.touchUpInside)
        //view.addSubview(postButtonMsgx!)
        
        
        var postButtonPhotox = fbTools.postButtonPhoto
        postButtonPhotox = UIButton(frame: CGRect(x:0, y:0, width:300, height:30))
        postButtonPhotox?.center = CGPoint(x: view.center.x, y: 480)
        postButtonPhotox?.setTitle("Post a Photo", for: UIControlState.normal)
        postButtonPhotox?.setTitleColor(UIColor.blue, for: UIControlState.normal)
        postButtonPhotox?.setTitleColor(UIColor.cyan, for: UIControlState.highlighted)
       // postButtonPhotox?.addTarget(self, action: #selector(fbTools.btnPostPhoto(sender:)), for: .touchUpInside)
        postButtonPhotox?.addTarget(self, action: Selector(("fbTools.btnPostPhoto:")), for: UIControlEvents.touchUpInside)
        
        //view.addSubview(postButtonPhotox!)

        fbTools.getFacebookUserInfo()
        
       
    }

    
    
    
    
    func loginButtonWillLogin(_ LoginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("didCompleteWithResult")
        
        fbTools.getFacebookUserInfo()
        
        let storyboard = UIStoryboard(name: "Main",bundle :nil)
        let tabvc = storyboard.instantiateViewController(withIdentifier: "tabVw") as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabvc
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("loginButtonDidLogOut")
        fbTools.imageView.image = UIImage(named: "fb-art.jpg")
        fbTools.label.text = "Not Logged  In"
        fbTools.buttonEnable(enable: false)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print("didFailWithError")
        fbTools.alertShow(typeStr: "Photo")
        
    }
    
    public func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
    
    public func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print("didCompleteWithResults")
        fbTools.alertShow(typeStr: "Photo")
        
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
