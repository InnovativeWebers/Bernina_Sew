//
//  ChangePhotoViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/14.
//

import UIKit
import Firebase
import SnapKit
class ChangePhotoViewController: UIViewController, ImagePickerDelegate {

    let profilePicture: UIImageView = {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: K.screenWidth - 16).isActive = true
        iv.heightAnchor.constraint(equalToConstant: K.screenWidth - 16).isActive = true
        return iv
    }()
    
    
    let selectButton = Tools.setUpButton("Select Photo", K.brandRed, 18)
    
    @objc func selectAction(sender: UIButton){
        sender.showAnimation {
            self.imgPicker?.present(from: sender)
        }
    }
    let user = Auth.auth().currentUser
    
    var imgPicker: ImagePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectButton.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
        
        view.backgroundColor = .white
        view.addSubview(profilePicture)
        view.addSubview(selectButton)
        
        if user?.photoURL != nil {

        }else{
            profilePicture.sd_setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9j2d6fOEChhiGl2e67ck-R5X5jlAEfTkjHQ&usqp=CAU"), completed: nil)
        }

        selectButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        selectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        self.imgPicker = ImagePicker(presentationController: self, delegate: self)

        profilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        profilePicture.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(150)
        }
        
        selectButton.snp.makeConstraints {(make) -> Void in
            make.bottom.equalTo(view).offset(-50)
        }

    }
    
    func didSelect(image: UIImage?) {
        profilePicture.image = image
    }

}
