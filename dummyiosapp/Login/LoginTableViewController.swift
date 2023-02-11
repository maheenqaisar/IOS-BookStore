//
//  LoginTableViewController.swift
//  dummyiosapp
//
//  Created by Maheen on 27/08/2022.
//

import UIKit
import Alamofire

class LoginTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardTappedAround()
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: navigationController, action: nil)
                navigationItem.leftBarButtonItem = backButton

                // Do any additional setup after loading the view, typically from a nib.
                
                //if user is already logged in switching to profile screen
                if defaultValues.string(forKey: "username") != nil{
                    let apinetwork = self.storyboard?.instantiateViewController(withIdentifier: "ApiNetworkViewController") as! ApiNetworkViewController
                    self.navigationController?.pushViewController(apinetwork, animated: true)
                    
                }

    }
    @IBAction func GoToSignUp(_ sender: UIButton) {
       let registerPage = self.storyboard?.instantiateViewController(withIdentifier: "RegisterTableViewController") as! RegisterTableViewController
        self.navigationController?.pushViewController(registerPage, animated: true)
    }
    //The login script url make sure to write the ip instead of localhost
        //you can get the ip using ifconfig command in terminal
        let URL_USER_LOGIN = "http://localhost/prototypephase/v1/login.php"
        
        //the defaultvalues to store user data
        let defaultValues = UserDefaults.standard
        
        //the connected views
        //don't copy instead connect the views using assistant editor
        @IBOutlet weak var labelMessage: UILabel!
        @IBOutlet weak var textFieldUserName: UITextField!
        @IBOutlet weak var textFieldPassword: UITextField!
        
        //the button action function
        @IBAction func buttonLogin(_ sender: UIButton) {
            
            //getting the username and password
            let parameters: Parameters=[
                "username":textFieldUserName.text!,
                "password":textFieldPassword.text!
            ]
            
            //making a post request
            Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        
                        //if there is no error
                        if(!(jsonData.value(forKey: "error") as! Bool)){
                            
                            //getting the user from response
                            let user = jsonData.value(forKey: "user") as! NSDictionary
                            
                            //getting user values
                            let userId = user.value(forKey: "id") as! Int
                            let userName = user.value(forKey: "username") as! String
                            let userEmail = user.value(forKey: "email") as! String
                            let userPhone = user.value(forKey: "phone") as! String
                            
                            //saving user values to defaults
                            self.defaultValues.set(userId, forKey: "userid")
                            self.defaultValues.set(userName, forKey: "username")
                            self.defaultValues.set(userEmail, forKey: "useremail")
                            self.defaultValues.set(userPhone, forKey: "userphone")
                            
                            //switching the screen
                            let apinetwork = self.storyboard?.instantiateViewController(withIdentifier: "ApiNetworkViewController") as! ApiNetworkViewController
                            self.navigationController?.pushViewController(apinetwork, animated: true)
                            
                            
                            self.dismiss(animated: false, completion: nil)
                        }else{
                            //error message in case of invalid credential
                            self.labelMessage.text = "Invalid username or password"
                        }
                    }
            }
        }
   
}
