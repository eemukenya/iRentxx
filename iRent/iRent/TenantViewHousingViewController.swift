//
//  TenantViewHousingViewController.swift
//  iRent
//
//  Created by Edwin Mukenya on 3/3/17.
//  Copyright © 2017 Edwin Mukenya. All rights reserved.
//

import UIKit

class TenantViewHousingViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(NSURLRequest(url: NSURL(string: "https://njati.000webhostapp.com/iRent/tenant_view_houses.php")! as URL) as URLRequest)

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

/*
self.view.addSubview(buttonx)

buttonx.translatesAutoresizingMaskIntoConstraints = false
buttonx.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
buttonx.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120).isActive = true


// buttonx.center=view.center

// self.view.addSubview(labelx)

postButtonMsg = UIButton(frame: CGRect(x:0,y:0, width:300, height:30))
// postButtonMsg.center = CGPoint(x: self.view.center.x, y: 480)
//  postButtonMsg.setTitle("Post a Message", for: UIControlState.normal)
//  postButtonMsg.setTitleColor(UIColor.blue, for: UIControlState.normal)
//  postButtonMsg.setTitleColor(UIColor.cyan, for: UIControlState.highlighted)
//   postButtonMsg.addTarget(self, action: Selector(("btnPostMsg:")), for: UIControlEvents.touchUpInside)
//   self.view.addSubview(postButtonMsgx)

postButtonPhoto = UIButton(frame: CGRect(x:0,y:0, width:300, height:30))
//  postButtonPhoto.center = CGPoint(x: view.center.x, y: 520)
// postButtonPhoto.setTitle("Post a Photo", for: UIControlState.normal)
// postButtonPhoto.setTitleColor(UIColor.blue, for: UIControlState.normal)
// postButtonPhoto.setTitleColor(UIColor.cyan, for: UIControlState.highlighted)
// postButtonPhoto.addTarget(self, action: Selector(("btnPostPhoto:")), for: UIControlEvents.touchUpInside)
// self.view.addSubview(postButtonPhotox)

getFacebookUserInfo()

/*
 let fbVideo:FBSDKShareVideo = FBSDKShareVideo()
 fbVideo.videoURL = url
 let content: FBSDKShareVideoContent = FBSDKShareVideoContent()
 content.video = fbVideo
 FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)*/

 
 /////////////////////////////////////////////////////////////////////
 
 let buttonx:UIButton = { var button = UIButton()
 button.backgroundColor = UIColor.blue
 button.setTitle("Choose Photo", for: .normal)
 //button = UIButton(frame: CGRect(x:(UIScreen.main.bounds.width - 150) * 0.5,y:125, width:300, height:30)) //CGRect((UIScreen.main.bounds.width - 150) * 0.5, 125, 150, 25)
 //button.center = CGPoint(x: self.view.center.x, y: 520)
 
 button.setTitleColor(UIColor.cyan, for: .highlighted)
 //  button.addTarget(self, action: Selector(("btnPostPhoto:")), for: .touchUpInside)
 button.addTarget(self, action: #selector(MovieDetailsViewController.btnPostPhoto(sender:)), for: .touchUpInside)
 //   button.addTarget(self, action: #selector(MovieDetailsViewController.photoBtnClicked), for: .touchUpInside)
 return button
 }()
 
 /*
 
 
 let labelx:UILabel = {
 let label = UILabel()
 label.frame = CGRectMake((UIScreen.main.bounds.width - 200) * 0.5, 100, 200, 25)
 label.text = "Photos Example"
 label.textAlignment = .center
 
 }()
 
 
 func photoBtnClicked(){
 if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum){
 println("Photo capture")
 imagePicker.delegate = self
 imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
 imagePicker.allowsEditing = false
 self.presentViewController(imagePicker, animated: true, completion: nil)
 }
 }
 
 private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
 
 let photo : FBSDKSharePhoto = FBSDKSharePhoto()
 photo.image = info[UIImagePickerControllerOriginalImage] as! UIImage
 photo.isUserGenerated = true
 let content : FBSDKSharePhotoContent = FBSDKSharePhotoContent()
 content.photos = [photo]
 }*/
 
 
 /////sorting share delegate
 
 func getFacebookUserInfo() {
 if(FBSDKAccessToken.current() != nil)
 {
 
 buttonEnable(enable: true)
 
 //print permissions, such as public_profile
 print(FBSDKAccessToken.current().permissions)
 let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"])
 graphRequest?.start(completionHandler: { (connection, result, error) -> Void in
 
 //self.label.text = result..valueForKey("name") as? String
 
 guard let data = result as? [String:Any] else { return }
 
 self.label.text = data["name"] as? String
 
 let FBid = data["id"] as! String
 
 
 
 let url = NSURL(string: "https://graph.facebook.com/\(FBid)/picture?type=large&return_ssl_resources=1")
 
 let imageData = NSData(contentsOf: url! as URL)
 let image = UIImage(data: imageData! as Data)
 
 
 self.imageView.image = image     //UIImage(data: NSData(contentsOfURL: url!)!)
 })
 } else {
 buttonEnable(enable: false)
 }
 }
 
 func buttonEnable(enable: Bool) {
 if enable {
 // postButtonMsg.alpha = 1
 // postButtonMsg.isEnabled = true
 // postButtonPhoto.alpha = 1
 // postButtonPhoto.isEnabled = true
 imageViewPost.alpha = 1
 } else {
 postButtonMsg.alpha = 0.3
 postButtonMsg.isEnabled = false
 postButtonPhoto.alpha = 0.3
 postButtonPhoto.isEnabled = false
 imageViewPost.alpha = 0.3
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
 FBSDKShareAPI.share(with: content, delegate: self)
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
 present(alertController, animated: true, completion: nil)
 }
 
 
 
 /////sorting share delegate

 
*/
