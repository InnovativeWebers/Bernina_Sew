//
//  ProfileViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    func logout(alert: UIAlertAction!){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            
            performSegue(withIdentifier: "profileToLogin", sender: self)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
        
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.title = "Profile"

        let imageIcon = UIImage(systemName: "face.smiling.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![4].selectedImage = imageIcon
        
    }
    

    @IBAction func logoutPressed(_ sender: UIButton) {
        
        sender.showAnimation {
            let alert = UIAlertController.init(title: "退出登录", message: "确定退出登录吗？", preferredStyle:.alert)
            let action1 = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            let action2 = UIAlertAction.init(title: "确定", style: .default, handler: self.logout)
            
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
