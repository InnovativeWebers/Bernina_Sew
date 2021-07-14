//
//  TabViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit

class TabViewController: UITabBarController {

    @IBOutlet weak var tab: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tab.items![0].image = UIImage(systemName: "house", withConfiguration: K.symbolConfig)? .withTintColor(.black, renderingMode: .alwaysOriginal)
        tab.items![1].image = UIImage(systemName: "person.and.person", withConfiguration: K.symbolConfig)? .withTintColor(.black, renderingMode: .alwaysOriginal)
        tab.items![2].image = UIImage(systemName: "paintpalette", withConfiguration:K.symbolConfig)? .withTintColor(.black, renderingMode: .alwaysOriginal)
        tab.items![3].image = UIImage(systemName: "cart", withConfiguration: K.symbolConfig)? .withTintColor(.black, renderingMode: .alwaysOriginal)
        tab.items![4].image = UIImage(systemName: "face.smiling", withConfiguration: K.symbolConfig)? .withTintColor(.black, renderingMode: .alwaysOriginal)
        
        let unselectedColor = UIColor.black
        let selectedColor = K.brandRed
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
    }
    
}
