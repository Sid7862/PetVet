//
//  ViewController.swift
//  life
//
//  Created by Rtstl Developer on 06/07/18.
//  Copyright © 2018 Ahmed Sahib. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class RegitserViewController: UIViewController {

    @IBOutlet var loginButton : FBSDKLoginButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
//        if (FBSDKAccessToken.current() != nil)
//        {
//             self.returnUserData()
//
//        }
//        else{
//
//        }
//       if (FBSDKAccessToken.currentAccessTokenIsActive())
//       {
//                self.returnUserData()
//
//       }
//       else
//       {
//
//       }
        
        if FBSDKAccessToken.current() != nil
        {
            print("Avalibale")
        }
        else{
            print("Not Avaliable")

        }
        
        
        
    
      
    }
    
    @IBAction func login(_ sender: Any)
    {
        self.facebooklogin()
    }
    
    func facebooklogin()
    {
        /*
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email","public_profile"], handler: { (result, error) -> Void in
            
            print("\n\n result: \(result)")
            print("\n\n Error: \(error)")
            
            if (error == nil)
            {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                
                if(fbloginresult.isCancelled) {
                    //Show Cancel alert
                } else if(fbloginresult.grantedPermissions.contains("email")) {
                    self.returnUserData()
                    
                    //fbLoginManager.logOut()
                }
            }
        })
        */
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.returnUserData()
                       // fbLoginManager.logOut()
                    }
                }
            }
        
    }

    }
    
    func returnUserData()
    {
        
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("\n\n Error: \(error)")
            }
            else
            {
                let resultDic = result as! NSDictionary
                print("\n\n  fetched user: \(result)")
                if (resultDic.value(forKey:"name") != nil)
                {
                    let userName = resultDic.value(forKey:"name")! as! String as NSString?
                    print("\n User Name is: \(userName)")
                }
                
                if (resultDic.value(forKey:"email") != nil)
                {
                    let userEmail = resultDic.value(forKey:"email")! as! String as NSString?
                    print("\n User Email is: \(userEmail)")
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

