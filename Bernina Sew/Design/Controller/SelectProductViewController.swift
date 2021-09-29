//
//  SelectProductViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/28.
//

import UIKit
import SnapKit
import SCLAlertView

class SelectProductViewController: UIViewController {

    let productLIst = Tools.loadProductList(filename: "featuredProductJSON")!.FeaturedProducts
    let productCollectionView = Tools.setUpCollectionView(10, 10, 100, 100)
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        Tools.setHeight(iv, Int(K.screenWidth) - 40)
        Tools.setWidth(iv, Int(K.screenWidth) - 40)
        return iv
    }()
    
    let nextButton = Tools.setUpButton("Done", K.brandRed, 25)
    
    @objc func nextPressed(sender: UIButton){
        sender.showAnimation {
            SCLAlertView().showTitle("Design created", subTitle: "Design has been added", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Design"
        view.backgroundColor = .white
        
        let imageIcon = UIImage(systemName: "paintpalette.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![2].selectedImage = imageIcon
        
        self.imageView.sd_setImage(with: URL(string: productLIst[0].Image), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        
        productCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        view.addSubview(productCollectionView)
        Tools.setHeight(productCollectionView, 100)
        productCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make  in
            make.top.equalTo(productCollectionView.snp_bottomMargin).offset(60)
            make.left.equalTo(20)
        }
        
        view.addSubview(nextButton)
        let tabHeight = K.userDefaults.float(forKey: "tabHeight")
        Tools.setHeight(nextButton, 55)
        nextButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20 - tabHeight)
        }
        

    }
    
}

extension SelectProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productLIst.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        cell.collectionImage.sd_setImage(with: URL(string: productLIst[indexPath.row].Image), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageView.sd_setImage(with: URL(string: productLIst[indexPath.row].Image), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
    }
    
    
}

