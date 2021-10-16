//
//  DesignCell.swift.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/14.
//

import UIKit
import SnapKit
class DesignCell: UITableViewCell {


    let container = Tools.setUpContainerView()
    let patternImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderColor = K.brandGray.cgColor
        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = 10
        Tools.setHeight(iv, 80)
        Tools.setWidth(iv, 80)
        return iv
    }()
    
    let productImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderColor = K.brandGray.cgColor
        iv.layer.borderWidth = 2
        iv.layer.cornerRadius = 10
        Tools.setHeight(iv, 80)
        Tools.setWidth(iv, 80)
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(container)
        container.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-8)
            make.right.equalTo(contentView).offset(-15)
        }
        
        container.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(container).offset(10)
            make.centerY.equalTo(container)
        }
        
        patternImageView.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp_rightMargin).offset(10)
            make.centerY.equalTo(container)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
