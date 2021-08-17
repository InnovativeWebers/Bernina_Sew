//
//  ProductTableViewCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/29.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {

    let productImageView = Tools.setUpImageView()
    
    let container = Tools.setUpContainerView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        contentView.addSubview(container)
        container.addSubview(productImageView)
        
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
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
