//
//  AddressCollectionCell.swift.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/13.
//

import UIKit
import SnapKit
class AddressCollectionCell: UICollectionViewCell {


    let container = Tools.setUpContainerView()
    let nameLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    let phoneNum: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let suburb: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let addressLine1: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let addressLine2: UILabel = {
        let lbl = UILabel()
        return lbl
    }()

 
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        container.layer.borderWidth = 3
        container.layer.borderColor = K.brandGray.cgColor
        
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-8)
            make.right.equalTo(contentView).offset(-15)
        }
        
        container.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make  in
            make.top.equalTo(container).offset(8)
            make.left.equalTo(container).offset(10)
        }
        
        container.addSubview(phoneNum)
        phoneNum.snp.makeConstraints { make  in
            make.left.equalTo(nameLabel.snp_rightMargin).offset(10)
            make.top.equalTo(container).offset(8)
        }
        
        container.addSubview(addressLine1)
        addressLine1.snp.makeConstraints { make  in
            make.top.equalTo(nameLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(container).offset(10)
        }
        
        container.addSubview(addressLine2)
        addressLine2.snp.makeConstraints { make  in
            make.top.equalTo(addressLine1.snp_bottomMargin).offset(8)
            make.left.equalTo(container).offset(10)
        }
        
        container.addSubview(suburb)
        suburb.snp.makeConstraints { make  in
            make.top.equalTo(addressLine2.snp_bottomMargin).offset(8)
            make.left.equalTo(container).offset(10)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
