//
//  ProductInfoViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit
import SCLAlertView

class ProductInfoViewController: UIViewController {
    var productName: String?
    var productImageUrl: String?
    var productPrice: String?
    var productID: Int?
    var productDescription: String?
    var offset = 20
    
    let productImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let productNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 25, weight: .semibold)
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = K.brandRed
        return lbl
    }()
    
    let productIDLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = K.brandGrey
        return lbl
    }()
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 15, weight: .regular)
        return tv
    }()
    
    let addToCartButton = Tools.setUpButton("Add to cart", K.brandRed, 25)
    
    @objc func addAction(sender: UIButton){
        sender.showAnimation {
            SCLAlertView().showTitle("Added", subTitle: "Check your cart", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        
        self.title = productName!
        
        productImage.sd_setImage(with: URL(string: productImageUrl!), completed: nil)
        productNameLabel.text = productName!
        productIDLabel.text = "ID: \(productID!)"
        priceLabel.text = productPrice
        descriptionTextView.text = productDescription!
        addToCartButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        addToCartButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        addToCartButton.setTitleColor(.white, for: .normal)
        
        view.addSubview(productImage)
        view.addSubview(productNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(productIDLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(addToCartButton)
        
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
        
        productIDLabel.snp.makeConstraints { make  in
            make.top.equalTo(productNameLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(view).offset(offset)
        }
        
        priceLabel.snp.makeConstraints { make  in
            make.top.equalTo(productIDLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(view).offset(offset)
        }
        
        Tools.setHeight(descriptionTextView, Int(K.screenHeight) / 4)
        descriptionTextView.snp.makeConstraints { make  in
            make.top.equalTo(priceLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        addToCartButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.bottom.equalTo(view).offset(-40)
        }
        
        

    }
}
