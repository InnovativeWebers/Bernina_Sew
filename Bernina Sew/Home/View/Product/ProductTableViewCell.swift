//
//  ProductTableViewCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/29.
//

import UIKit
import SDWebImage
import SCLAlertView

class ProductTableViewCell: UITableViewCell {

    let productImageView = Tools.setUpImageView()
    let container = Tools.setUpContainerView()
    let addButton = Tools.setUpButton("Add", K.brandRed, 16)
    let productName = UILabel()
    var productPrice = UILabel()
    
    @objc func addPressed(sender: UIButton){
        sender.showAnimation {
            SCLAlertView().showTitle("Added", subTitle: "Check your cart", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        productName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        productPrice.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        productPrice.textColor = K.brandRed
        
        addButton.addTarget(self, action: #selector(addPressed(sender:)), for: .touchUpInside)
        
        contentView.addSubview(container)
        container.addSubview(productImageView)
        container.addSubview(productName)
        container.addSubview(productPrice)
        container.addSubview(addButton)
        
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
        Tools.setWidth(addButton, 60)
        addButton.snp.makeConstraints { make  in
            make.centerY.equalTo(container)
            make.right.equalTo(container).offset(-20)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
