//
//  TableViewCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/13.
//

import UIKit
import SnapKit
import Firebase
import FirebaseStorage

class BlogCell: UITableViewCell {
    
    let containerView = Tools.setUpContainerView()
    
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = false
        tv.isEditable = false
        return tv
    }()
    
    let offset = 15
    
    let profilePic = Tools.setUpImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        
        

        containerView.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.right.equalTo(contentView).offset(-8)
        }
        containerView.addSubview(profilePic)

        profilePic.snp.makeConstraints { make  in
            make.top.equalTo(containerView).offset(offset)
            make.left.equalTo(containerView).offset(offset)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make  in
            make.left.equalTo(profilePic.snp_rightMargin).offset(offset)
            make.top.equalTo(containerView).offset(offset)
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make  in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(offset)
            make.left.equalTo(profilePic.snp_rightMargin).offset(offset)
        }
        

        
        
        let user = Auth.auth().currentUser
        let storage = Storage.storage()

        let handle = Auth.auth().addStateDidChangeListener { [self] auth, user in
            if Auth.auth().currentUser != nil {

            if user?.photoURL != nil {
                let storageRef = storage.reference()
                let imageRef = storageRef.child("profileImages/profile.jpg")
                // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                imageRef.getData(maxSize: 1 * 1024 * 1024) { [self] data, error in
                    if error != nil {
                        print(error!.localizedDescription)
                  } else {
                        profilePic.image = UIImage(data: data!)
                  }
            }

            }
            
            } else {
                print("the user is not signed in")
              // ...
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
