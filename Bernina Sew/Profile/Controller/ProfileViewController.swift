//
//  ProfileViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var AccountButton: UIButton!
    @IBOutlet weak var bookingsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func acountButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func bookingsButtonPressed(_ sender: Any) {
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
    }
    
    
    func logout(alert: UIAlertAction!){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            performSegue(withIdentifier: "profileToLogin", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    let user = Auth.auth().currentUser

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Profile"

        let imageIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![4].selectedImage = imageIcon
        
        nameLabel.text = "Bernina-User-\(user?.uid.prefix(5) ?? "0001")"
        
        emailLabel.text = user?.email
        
        
    }
    

    @IBAction func logoutPressed(_ sender: UIButton) {
        
        sender.showAnimation {
            let alert = UIAlertController.init(title: "Log out", message: "Are you sure？", preferredStyle:.alert)
            let action1 = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            let action2 = UIAlertAction.init(title: "Log out", style: .default, handler: self.logout)
            
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
