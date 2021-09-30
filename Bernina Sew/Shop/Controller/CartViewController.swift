//
//  CartViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/30.
//

import UIKit

class CartViewController: UIViewController {
    let cartTableView = Tools.setUpTableView()
    var cartList = [Product]()
    
    
    let checkOutButton = Tools.setUpButton("Check out", K.brandRed, 25)
    
    @objc func checkPressed(sender: UIButton){
        sender.showAnimation {

            
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Cart"
        view.backgroundColor = .white
        
        if let data = UserDefaults.standard.object(forKey: "Products") as? NSData {
        cartList = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Product]
           }
        
        checkOutButton.addTarget(self, action: #selector(checkPressed(sender:)), for: .touchUpInside)

        cartTableView.delegate = self
        cartTableView.dataSource = self
        cartTableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        cartTableView.rowHeight = 116
        
        view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        view.addSubview(checkOutButton)
        Tools.setHeight(checkOutButton, 55)
        checkOutButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
        

    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        cell.productImageView.sd_setImage(with: URL(string: cartList[indexPath.row].Image!), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        cell.productName.text = cartList[indexPath.row].Name
        cell.selectionStyle = .none
        cell.productPrice.text = "$ \(cartList[indexPath.row].Price!)"
        return cell
    }
    
    
}

