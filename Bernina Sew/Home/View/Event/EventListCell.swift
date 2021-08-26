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
        lbl.font = .systemFont(ofSize: 13, weight: .bold)
        lbl.backgroundColor = K.brandRed
        lbl.layer.cornerRadius = 10
        lbl.textAlignment = .center
        lbl.widthAnchor.constraint(equalToConstant: K.screenWidth / 3 - 10 - 10 - 32).isActive = true
        
        return lbl
    }()

    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 15, weight: .bold)
        lbl.backgroundColor = K.darkGreen
        lbl.layer.cornerRadius = 10
        lbl.textAlignment = .center
//        lbl.widthAnchor.constraint(equalToConstant: K.screenWidth / 3 - 10 - 10 - 32).isActive = true
        
        return lbl
    }()
    
    let eventLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13, weight: .bold)
        lbl.textAlignment = .center
        lbl.widthAnchor.constraint(equalToConstant: K.screenWidth / 3 - 10 - 10 - 32).isActive = true
        return lbl
    }()
    


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dateLabel.widthAnchor.constraint(equalToConstant: 130).isActive = true
        dateLabel.textColor = .white

        contentView.addSubview(levelLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(eventLabel)

        
        contentView.layer.borderColor = K.brandGrey.cgColor
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 10
        
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        levelLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.right.equalTo(contentView).offset(-16)
        }
        
        eventLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView).offset(16)
        }
        
        dateLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)

        }
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        
        levelLabel.textColor = .white
        dateLabel.layer.cornerRadius = 10
        dateLabel.clipsToBounds = true
        levelLabel.layer.cornerRadius = 10
        levelLabel.clipsToBounds = true
        
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

