//
//  ProductInfoViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit
import SDWebImage

class ProductInfoViewController: UIViewController {
    var productName: String?
    var productImageUrl: String?
    var productPrice: String?
    var offset = 20
    
    let productImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let productNameLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        
        productImage.sd_setImage(with: URL(string: productImageUrl!), completed: nil)
        productNameLabel.text = productName
        priceLabel.text = productPrice
        
        view.addSubview(productImage)
        view.addSubview(productNameLabel)
        view.addSubview(priceLabel)
        
        Tools.setHeight(productImage, Int(K.screenHeight) / 3)
        
        productImage.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(offset)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        productNameLabel.snp.makeConstraints {  make  in
            make.top.equalTo(productImage.snp_bottomMargin).offset(offset)
            make.left.equalTo(view).offset(offset)
        }
        

    }
}
