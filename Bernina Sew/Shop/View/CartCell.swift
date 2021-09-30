//
//  CartCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/30.
//

import UIKit
import SDWebImage
import SCLAlertView

class CartCell: UITableViewCell {


    let productImageView = Tools.setUpImageView()
    let container = Tools.setUpContainerView()
    let productName = UILabel()
    var productPrice = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        productName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        productPrice.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        productPrice.textColor = K.brandRed

        contentView.addSubview(container)
        container.addSubview(productImageView)
        container.addSubview(productName)
        container.addSubview(productPrice)

        
        container.snp.makeConstraints { make  in
            make.top.equalTo(contentView).offset(8)
            make.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView).offset(-8)
            make.right.equalTo(contentView).offset(-15)
        }
        
        productImageView.snp.makeConstraints { make  in
            make.top.equalTo(container).offset(15)
            make.left.equalTo(container).offset(15)
        }
        
        productName.snp.makeConstraints { make  in
            make.top.equalTo(container).offset(20)
            make.left.equalTo(productImageView.snp_rightMargin).offset(20)
        }
        
        productPrice.snp.makeConstraints { make  in
            make.top.equalTo(productName.snp_bottomMargin).offset(20)
            make.left.equalTo(productImageView.snp_rightMargin).offset(20)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
