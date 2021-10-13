//
//  DesignViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit
import SnapKit

class DesignViewController: UIViewController {

    let patternsList = Tools.loadPatternList(filename: "patternJSON")!.Patterns
    let patternCollectionView = Tools.setUpCollectionView(10, 10, 100, 100)
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        Tools.setHeight(iv, Int(K.screenWidth) - 40)
        Tools.setWidth(iv, Int(K.screenWidth) - 40)
        return iv
    }()
    
    let nextButton = Tools.setUpButton("Next➡", K.brandRed, 25)
    
    @objc func nextPressed(sender: UIButton){
        sender.showAnimation {
            let vc = SelectProductViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        if #available(iOS 15, *){
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // isTranslucent = true
            appearance.backgroundColor = .white
            self.navigationController?.navigationBar.standardAppearance = appearance;
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Design"
        self.navigationController?.navigationBar.tintColor = K.brandRed
        
        let imageIcon = UIImage(systemName: "paintpalette.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![2].selectedImage = imageIcon
        
        self.imageView.sd_setImage(with: URL(string: patternsList[0].Image!), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        
        patternCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        patternCollectionView.delegate = self
        patternCollectionView.dataSource = self
        self.patternCollectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)

        
        view.addSubview(patternCollectionView)
        Tools.setHeight(patternCollectionView, 100)
        patternCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make  in
            make.top.equalTo(patternCollectionView.snp_bottomMargin).offset(60)
            make.left.equalTo(20)
        }
        
        view.addSubview(nextButton)
        Tools.setHeight(nextButton, 55)
        nextButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
        

    }
    
}

extension DesignViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return patternsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        cell.collectionImage.sd_setImage(with: URL(string: patternsList[indexPath.row].Image!), completed: nil)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageView.sd_setImage(with: URL(string: patternsList[indexPath.row].Image!), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderColor = K.brandRed.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderColor = K.brandGray.cgColor
    }
}
