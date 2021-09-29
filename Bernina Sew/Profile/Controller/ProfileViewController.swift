//
//  ProfileViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var AccountButton: UIButton!
    @IBOutlet weak var bookingsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBAction func acountButtonPressed(_ sender: UIButton) {
        let alert = Tools.setUpLoginAlert(self)
        if Auth.auth().currentUser == nil {
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let vc = AccountViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @IBAction func bookingsButtonPressed(_ sender: Any) {
        let vc = MyBookingsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let vc = SettingsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func designsButtonPressed(_ sender: Any) {
        let vc = DesignsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    let user = Auth.auth().currentUser
    let storage = Storage.storage()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.tintColor = K.brandRed
        let handle = Auth.auth().addStateDidChangeListener { [self] auth, user in
            if Auth.auth().currentUser != nil {
              // User is signed in.
              print("the user is signed in")
            if user?.displayName == nil {
                nameLabel.text = "Bernina-User-\(user?.uid.prefix(5) ?? "Temp")"
            }else{
                self.nameLabel.text = user?.displayName
            }
            emailLabel.text = user?.email
            
            if user?.photoURL != nil {
                let storageRef = storage.reference()
                let imageRef = storageRef.child("profileImages/profile.jpg")
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                imageRef.getData(maxSize: 1 * 1024 * 1024) { [self] data, error in
                    if error != nil {
                        print(error!.localizedDescription)
                  } else {
                    // Data for "images/island.jpg" is returned
                        profileImage.image = UIImage(data: data!)

                  }
            }

            }
            
            } else {
              // No user is signed in.
                print("the user is not signed in")
              // ...
            }
        }
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = K.brandGrey.cgColor
        profileImage.layer.cornerRadius = 12
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        


        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Profile"

        let imageIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![4].selectedImage = imageIcon
        
//        let userName = UserDefaults.standard.string(forKey: "username")
//        if (userName != nil) {
//            nameLabel.text = userName as? String
//        }
//

        if user?.displayName == nil {
            nameLabel.text = "Bernina-User-\(user?.uid.prefix(5) ?? "Temp")"
        }else{
            nameLabel.text = user?.displayName
        }
        emailLabel.text = user?.email
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
