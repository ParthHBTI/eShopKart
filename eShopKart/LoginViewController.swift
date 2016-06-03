//
//  LoginViewController.swift
//  eShopKart
//
//  Created by mac on 25/05/16.
//  Copyright © 2016 kloudRac.com. All rights reserved.
//

import UIKit
import SinchVerification
class LoginViewController: UIViewController , UITextFieldDelegate {
    
    var verification: Verification!
    var applicationKey = "a15ab125-a121-4dc9-b4d7-cbd6874262e2"

    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumber.delegate = self
        self.passwordField.delegate = self
        
        let myUrl = NSURL(string: "http://192.168.0.13/eshopkart/webservices/signup");
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        print("testing")
        let postString = "firstname=kamlesh&lastname=kumar&email=kkumar@kloudrac.com&password=123456&mobile=9582491764"
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil
            {
                print("error=\(error)")
                print("testing")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            
            //Let’s convert response sent from a server side script to a NSDictionary object:
            
            
            do
            {
                let myJSON = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves ) as? NSDictionary
                if let parseJSON = myJSON {
                    
                    let firstNameValue = parseJSON["firstName"] as? String
                    
                    print("firstNameValue: \(firstNameValue)")
                }
                
            } catch let error as NSError {
                print(error);}
            
        }
        
        task.resume()



        // Do any additional setup after loading the view.
    }

    @IBAction func crossAction(sender: AnyObject) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgetVerificationSend(sender: AnyObject) {
        verification = SMSVerification(applicationKey: applicationKey, phoneNumber: phoneNumber.text!);        verification.initiate { (success:Bool, error:NSError?) -> Void in
            print("\(success)")
           // self.disableUI(false);
           let text = (success ? "Verified" : error?.description);
              print("\(text)")
        }
        
    }
    

     func textFieldShouldReturn(textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true;
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}