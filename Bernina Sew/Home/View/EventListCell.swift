//
//  EventListCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/14.
//

import UIKit

class EventListCell: UITableViewCell {

    let levelLabel: UILabel = {
        let lbl = UILabel()
        
        return lbl
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        

        
        contentView.addSubview(levelLabel)
        
        levelLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-100)
        }
        
        
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

