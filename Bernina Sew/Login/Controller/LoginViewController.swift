//
//  MeViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func showAlert(_ sender: Any, _ title: String) {
        let alertController = UIAlertController(title: title, message:
            "Please try again!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        


    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        loginButton.layer.cornerRadius = 10
        loginButton.backgroundColor = K.brandRed
        
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.layer.cornerRadius = 10
        
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.layer.cornerRadius = 10
        
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        emailTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
        
    }

    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeTabBarController = storyboard.instantiateViewController(identifier: "HomeTabBarController")
        
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            // get the login status
            Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
              
                // handle user inputs when there is an error
                if error != nil{
                    if let errCode = AuthErrorCode(rawValue: error!._code){
                        switch errCode.rawValue{
                        case 17008:
                            self.showAlert(UIButton.self, "Invalid email format")
                            break
                        case 17011:
                            self.showAlert(UIButton.self, "Account not registered")
                        case 17009:
                            self.showAlert(UIButton.self, "Incorrect password")
                        default:
                            break
                        }
                    }
                }else{
 
                    // transit to home screen when there is no error
                    performSegue(withIdentifier: "LoginToHome", sender: self)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate )?.changeRootViewController( homeTabBarController)
                }
            }
        }
    }


}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderColor = K.brandRed.cgColor
            emailTextField.layer.borderWidth = 2.5
        }else{
            passwordTextField.layer.borderColor = K.brandRed.cgColor
            passwordTextField.layer.borderWidth = 2.5
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextField.layer.borderColor = UIColor.black.cgColor
            emailTextField.layer.borderWidth = 1.0
        }else {
            passwordTextField.layer.borderColor = UIColor.black.cgColor
            passwordTextField.layer.borderWidth = 1.0
        }
    }
    
    
}
