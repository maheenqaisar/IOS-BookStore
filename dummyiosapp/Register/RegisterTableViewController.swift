//
//  RegisterTableViewController.swift
//  dummyiosapp
//
//  Created by Maheen on 27/08/2022.
//

import Alamofire
import UIKit

class RegisterTableViewController: UITableViewController{
    
  
    @IBAction func cancelButtonTapped(_ sender: Any) {
        print("Cancel Button Go To Login Page")
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SignIn(_ sender: Any) {
        print("Back to Log In")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //HTTP Request
    let URL_USER_REGISTER = "http://localhost/prototypephase/v1/register.php"
        
        //View variables
        @IBOutlet weak var textFieldUsername: UITextField!
        @IBOutlet weak var textFieldPassword: UITextField!
        @IBOutlet weak var textFieldEmail: UITextField!
        @IBOutlet weak var textFieldName: UITextField!
        @IBOutlet weak var textFieldPhone: UITextField!
        @IBOutlet weak var labelMessage: UILabel!
        
        //Button action
        @IBAction func buttonRegister(_ sender: UIButton) {
            
            //creating parameters for the post request
            let parameters: Parameters = [
                "username":textFieldUsername.text!,
                "password":textFieldPassword.text!,
                "name":textFieldName.text!,
                "email":textFieldEmail.text!,
                "phone":textFieldPhone.text!
            ]
            
            //Sending http post request
            Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    
                    //displaying the message in label or in Alert message
                    self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                    //self.alert(message: "All Fields Are Required !")
                }
            }
        
        }

    func alert(message: String, title: String = "") {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
 
}
