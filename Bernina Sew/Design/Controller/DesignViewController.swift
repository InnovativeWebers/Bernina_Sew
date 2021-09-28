//
//  DesignViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/06/2020.
//

import UIKit

class DesignViewController: UIViewController {

    
    let favoritedCollectionView = Tools.setUpCollectionView(10, 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Design"
        
        let imageIcon = UIImage(systemName: "paintpalette.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![2].selectedImage = imageIcon
        

    }
    

}
