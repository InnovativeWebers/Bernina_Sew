//
//  AccountViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/14.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {

    let changeUserNameButton = Tools.setUpButton("Change Username", K.brandRed, 18)
    
    @objc func changeUserNameAction(sender: UIButton){
        sender.showAnimation {
            let vc = ChangeUserNameViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    let changePhotoButton = Tools.setUpButton("Change Profile Photo", K.brandRed, 18)
    
    @objc func changePhotoAction(sender: UIButton){
        sender.showAnimation {
            let vc = ChangePhotoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

   
        Tools.setHeight(changeUserNameButton, 50)
        Tools.setHeight(changePhotoButton, 50)
        
        view.backgroundColor = .white
        
        changeUserNameButton.addTarget(self, action: #selector(changeUserNameAction(sender:)), for: .touchUpInside)
        changePhotoButton.addTarget(self, action: #selector(changePhotoAction(sender:)), for: .touchUpInside)
        view.addSubview(changeUserNameButton)
        view.addSubview(changePhotoButton)
        
        changeUserNameButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        changePhotoButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(changeUserNameButton.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
    }

}
