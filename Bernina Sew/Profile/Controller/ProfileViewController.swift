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
        
        let alert = Tools.setUpLoginAlert(self)
        if Auth.auth().currentUser == nil {
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let vc = MyBookingsViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let alert = Tools.setUpLoginAlert(self)
        if Auth.auth().currentUser == nil {
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let vc = SettingsViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        let alert = Tools.setUpLoginAlert(self)
        if Auth.auth().currentUser == nil {
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let vc = MyFavorietesViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    @IBAction func designsButtonPressed(_ sender: Any) {
        let alert = Tools.setUpLoginAlert(self)
        if Auth.auth().currentUser == nil {
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let vc = DesignsViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func ordersButtonPressed(_ sender: Any) {
        let alert = Tools.setUpLoginAlert(self)
        if Auth.auth().currentUser == nil {
            self.present(alert, animated: true, completion: nil)
            
        }else {
            let vc = OrdersViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @objc func loginPressed(sender: UIButton){
        sender.showAnimation {
            self.performSegue(withIdentifier: "profileToLogin", sender: self)
        }
    }
    
    let loginButton = Tools.setUpButton("Login", K.brandRed, 20)

    
    let user = Auth.auth().currentUser
    let storage = Storage.storage()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if #available(iOS 15, *){
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // isTranslucent = true
            appearance.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance = appearance;
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }
        self.navigationController?.navigationBar.tintColor = K.brandRed
        let handle = Auth.auth().addStateDidChangeListener { [self] auth, user in
            if Auth.auth().currentUser != nil {
              // User is signed in.
            if user?.displayName == nil {
                nameLabel.text = "Bernina-User-\(user?.uid.prefix(5) ?? "Temp")"
            }else{
                self.nameLabel.text = user?.displayName
            }
            emailLabel.text = user?.email
            loginButton.isHidden = true
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
                loginButton.isHidden = false
                profileImage.image = UIImage(named: "bernina-red")
                print("the user is not signed in")
              // ...
            }
        }
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderWidth = 1.5
        profileImage.layer.borderColor = K.brandGray.cgColor
        profileImage.layer.cornerRadius = 12
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        loginButton.addTarget(self, action: #selector(loginPressed(sender:)), for: .touchUpInside)
        


        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Profile"

        let imageIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![4].selectedImage = imageIcon
        

        if user?.displayName == nil {
            nameLabel.text = "Bernina-User-\(user?.uid.prefix(5) ?? "Temp")"
        }else{
            nameLabel.text = user?.displayName
        }
        emailLabel.text = user?.email
        
        
        view.addSubview(loginButton)
        Tools.setHeight(loginButton, 45)
        loginButton.snp.makeConstraints { make  in
            make.left.equalTo(profileImage.snp_rightMargin).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(16)
        }
    }
    

    

}
