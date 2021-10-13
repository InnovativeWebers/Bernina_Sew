//
//  CheckoutViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/30.
//

import UIKit

class CheckoutViewController: UIViewController {

    var cartList: [Product]?
    
    let productCollectionView: UICollectionView = {
        let cellSize = CGSize(width: 60, height: 60)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = CGFloat(10)
        layout.minimumInteritemSpacing = CGFloat(10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        Tools.setHeight(cv, 80)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let priceContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 3
        v.layer.borderColor = K.brandRed.cgColor
        Tools.setHeight(v, 130)
        return v
    }()
    
    let paymentTableView = Tools.setUpTableView()
    
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = K.brandRed
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    func GetTotalPrice(_ cart: [Product]) -> Int{
        var price = 0
        for product in cart {
            price = price + product.Price!
        }
        return price
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Check out"
        let price = GetTotalPrice(cartList!)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        
        priceLabel.text = "Total price: $\(price)"
        view.addSubview(priceContainer)
        priceContainer.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        priceContainer.addSubview(productCollectionView)
        productCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(priceContainer).offset(10)
            make.left.equalTo(priceContainer).offset(16)
            make.right.equalTo(priceContainer).offset(-16)
        }
        
        
        priceContainer.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make  in
            make.top.equalTo(productCollectionView.snp_bottomMargin).offset(10)
            make.centerX.equalTo(priceContainer.snp_centerX)
        }
        
        paymentTableView.layer.borderWidth = 3
        paymentTableView.layer.borderColor = K.brandRed.cgColor
        paymentTableView.layer.cornerRadius = 10
        paymentTableView.isScrollEnabled = false
        Tools.setHeight(paymentTableView, 150)
        
        view.addSubview(paymentTableView)
        paymentTableView.snp.makeConstraints { make  in
            make.top.equalTo(priceContainer.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    
}

extension CheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartList!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.collectionImage.sd_setImage(with: URL(string: cartList![indexPath.row].Image!), completed: nil)
        return cell
    }
    
}
