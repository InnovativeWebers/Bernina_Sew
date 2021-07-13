//
//  ProfileViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"

        let imageIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![4].selectedImage = imageIcon
    }
    

    @IBAction func logoutPressed(_ sender: UIButton) {
        
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print ("Error signing out: %@", signOutError)
    }
      
    }

}
