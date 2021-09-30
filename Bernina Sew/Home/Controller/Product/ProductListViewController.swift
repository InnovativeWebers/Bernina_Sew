//
//  ProductListViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit

class ProductListViewController: UIViewController {
    
    let productTableView = Tools.setUpTableView()
    var productList: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Products"
        view.backgroundColor = .white
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        productTableView.rowHeight = 116
        
        view.addSubview(productTableView)
        productTableView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.productImageView.sd_setImage(with: URL(string: productList![indexPath.row].Image!), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        cell.productName.text = productList![indexPath.row].Name
        cell.selectionStyle = .none
        cell.productPrice.text = "$ \(productList![indexPath.row].Price!)"
        cell.productID = productList![indexPath.row].ID
        cell.productDescription = productList![indexPath.row].Description
        cell.productPriceValue = productList![indexPath.row].Price
        cell.productImageUrl = productList![indexPath.row].Image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductInfoViewController()
        vc.productImageUrl = productList![indexPath.row].Image
        vc.productPrice = "$ \(productList![indexPath.row].Price!)"
        vc.productPriceValue = productList![indexPath.row].Price
        vc.productID = productList![indexPath.row].ID
        vc.productName = productList![indexPath.row].Name
        vc.productDescription = productList![indexPath.row].Description
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
