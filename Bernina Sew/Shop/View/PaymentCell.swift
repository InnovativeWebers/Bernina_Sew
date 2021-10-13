//
//  PaymentCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/12.
//


import UIKit

class PaymentCell: UITableViewCell {

    let container: UIView = {
        let v = UIView()
        v.layer.borderColor = K.brandGray.cgColor
        v.layer.borderWidth = 3
        v.layer.cornerRadius = 10
        return v
    }()
    
    let paymentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Credit Card"
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        return lbl
    }()
    
    let selectionImageView: UIImageView = {
        let iv = UIImageView()
        let symbolConfig = UIImage.SymbolConfiguration(scale: .small)
        iv.image = UIImage(systemName: "circle.circle", withConfiguration: symbolConfig)?.withTintColor(K.brandGray).withRenderingMode(.alwaysOriginal)
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
        container.addSubview(paymentLabel)
        paymentLabel.snp.makeConstraints { make in
            make.top.equalTo(container).offset(10)
            make.left.equalTo(container).offset(10)
            make.right.equalTo(container).offset(-10)
            make.bottom.equalTo(container).offset(-10)
        }
        
        container.addSubview(selectionImageView)
        selectionImageView.snp.makeConstraints { make in
            make.centerY.equalTo(container)
            make.right.equalTo(container).offset(-20)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
