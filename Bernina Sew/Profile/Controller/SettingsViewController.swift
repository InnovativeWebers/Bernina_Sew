//
//  SettingsViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/29.
//

import UIKit
import SnapKit
import Firebase

class SettingsViewController: UIViewController {

    let aboutButton = Tools.setUpButton("About Us", K.brandRed, 18)
    let logoutButton = Tools.setUpButton("Log Out", K.brandRed, 18)
    
    
    func logout(alert: UIAlertAction!){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    @objc func logoutPressed(_ sender: UIButton) {
        
        sender.showAnimation {
            let alert = UIAlertController.init(title: "Log out", message: "Are you sure？", preferredStyle:.alert)
            let action1 = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            let action2 = UIAlertAction.init(title: "Log out", style: .default, handler: self.logout)
            
            alert.addAction(action1)
            alert.addAction(action2)
            self.present(alert, animated: true, completion: nil)
        }
    }
    

    
    @objc func aboutPressed(sender: UIButton){
        sender.showAnimation {
            let vc = AboutViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Settings"

        Tools.setHeight(logoutButton, 50)
        Tools.setHeight(aboutButton, 50)

        logoutButton.addTarget(self, action: #selector(logoutPressed(_:)), for: .touchUpInside)
        aboutButton.addTarget(self, action: #selector(aboutPressed(sender:)), for: .touchUpInside)
        
        

        
        view.addSubview(aboutButton)
        aboutButton.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(20)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make  in
            make.top.equalTo(aboutButton.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        

        // Do any additional setup after loading the view.
    }
    


}
