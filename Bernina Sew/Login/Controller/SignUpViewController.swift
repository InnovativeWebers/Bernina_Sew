//
//  SignUpViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    @IBAction func showAlert(_ sender: Any, _ title: String) {
        let alertController = UIAlertController(title: title, message:
            "Please try again!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.layer.cornerRadius = 10
        
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.layer.cornerRadius = 10
        
        reEnterPasswordTextField.layer.borderWidth = 1.0
        reEnterPasswordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        reEnterPasswordTextField.layer.cornerRadius = 10
        
        emailTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        reEnterPasswordTextField.borderStyle = .none
        
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        reEnterPasswordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        emailTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        reEnterPasswordTextField.setLeftPaddingPoints(10)
        
        
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.2705882353, blue: 0.3764705882, alpha: 1)
        
 
    }
    
    
    @IBAction func backButtonPresses(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    
        if let password = passwordTextField.text, let reEnter = reEnterPasswordTextField.text,
           let email = emailTextField.text
            {
            
                if password.count < 6 || reEnter.count < 6{
                    showAlert(UIButton.self, "Password must contain at least 6 characters")
                }
                else if password != reEnter{
                    showAlert(UIButton.self, "Passwords do not match!")
                    
                }else{
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                      
                        if error != nil{
                            
                            if let errCode = AuthErrorCode(rawValue: error!._code){
                                print(errCode.rawValue)
                                switch errCode.rawValue{
                                case 17008:
                                    self.showAlert(UIButton.self, "Invalid email format")
                                    break
                                case 17007:
                                    self.showAlert(UIButton.self, "You have already registered, please login")
                                default:
                                    break
                                }
                                    
                            }

                    }else{
                        
                        self.performSegue(withIdentifier: "SignupToLogin", sender: self)
                    }
                
                        
                }
            }
    }
    

}
}
