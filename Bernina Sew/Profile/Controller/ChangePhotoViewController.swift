//
//  ChangePhotoViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/14.
//

import UIKit
import Firebase
import SnapKit
import FirebaseStorage

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
    let storage = Storage.storage()
    var imgPicker: ImagePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Update profile photo"
        
        selectButton.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
        
        view.backgroundColor = .white
        view.addSubview(profilePicture)
        view.addSubview(selectButton)
        
        if user?.photoURL != nil {
            let storageRef = storage.reference()
            let imageRef = storageRef.child("profileImages/profile.jpg")
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imageRef.getData(maxSize: 1 * 1024 * 1024) { [self] data, error in
              if let error = error {
                    print(error)
              } else {
                // Data for "images/island.jpg" is returned
                profilePicture.image = UIImage(data: data!)
              }
            }
        }else{
            profilePicture.sd_setImage(with: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9j2d6fOEChhiGl2e67ck-R5X5jlAEfTkjHQ&usqp=CAU"), completed: nil)
        }


        
        // Data in memory
     
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
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imagesRef = storageRef.child("profileImages")
        
        let profileRef = imagesRef.child("profile.jpg")
        let data = image?.jpeg(.lowest)

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = profileRef.putData(data!, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          profileRef.downloadURL { (url, error) in
            if error == nil {
                changeRequest?.photoURL = url
                changeRequest?.commitChanges { error in
                    CBToast.showToastAction(message: "Done!")
                }
              }
            }
          }
        }
    }


