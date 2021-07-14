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
        
        Tools.setHeight(levelLabel, 60)
        
        contentView.addSubview(levelLabel)
        
        
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

