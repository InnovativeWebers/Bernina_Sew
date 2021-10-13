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
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
