//
//  CollectionCell.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/15.
//

import UIKit

class CollectionCell: UICollectionViewCell {


    let collectionImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(collectionImage)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 3.0
        contentView.layer.borderColor = K.brandGrey.cgColor
        

        collectionImage.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(contentView).offset(5)
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-5)
            make.bottom.equalTo(contentView).offset(-5)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
