//
//  OrderCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/14.
//

import UIKit
import SnapKit
class OrderCell: UITableViewCell {


    let container = Tools.setUpContainerView()
    
    let orderNumLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return lbl
    }()
    
    let orderDateLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()
    
    let orderValueLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 23, weight: .semibold)
        lbl.textColor = K.brandRed
        
        return lbl
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
        
        container.addSubview(orderNumLabel)
        orderNumLabel.snp.makeConstraints { make in
            make.top.equalTo(container).offset(16)
            make.left.equalTo(container).offset(16)
        }
        
        container.addSubview(orderDateLabel)
        orderDateLabel.snp.makeConstraints { make in
            make.top.equalTo(orderNumLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(container).offset(16)
        }
        
        container.addSubview(orderValueLabel)
        orderValueLabel.snp.makeConstraints { make in
            make.right.equalTo(container).offset(-16)
            make.centerY.equalTo(container)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
