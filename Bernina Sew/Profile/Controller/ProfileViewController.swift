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
        let vc = AccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
    let storage = Storage.storage()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        profileImage.contentMode = .scaleAspectFill
        
        if user?.photoURL == nil {
            profileImage.sd_setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9j2d6fOEChhiGl2e67ck-R5X5jlAEfTkjHQ&usqp=CAU"), completed: nil)

        }else{
            let storageRef = storage.reference()
            let islandRef = storageRef.child("profileImages/profile.jpg")
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            islandRef.getData(maxSize: 1 * 1024 * 1024) { [self] data, error in
              if let error = error {
                // Uh-oh, an error occurred!
              } else {
                // Data for "images/island.jpg" is returned
                profileImage.image = UIImage(data: data!)
              }
            }
        }
  
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Profile"

        let imageIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![4].selectedImage = imageIcon
        
        if user?.displayName == nil {
            nameLabel.text = "Bernina-User-\(user?.uid.prefix(5) ?? "0001")"
        }else{
            nameLabel.text = user?.displayName
        }

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
