//
//  ProductListViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit

class ProductListViewController: UIViewController {
    
    let productTableView = Tools.setUpTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Products"
        
        
        
    }
    
    
}
