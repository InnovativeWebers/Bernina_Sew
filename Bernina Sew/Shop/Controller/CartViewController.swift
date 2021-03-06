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
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "No items added."
        lbl.font = .systemFont(ofSize: 20)
        lbl.textColor = K.brandRed
        return lbl
    }()
    
    @objc func checkPressed(sender: UIButton){
        sender.showAnimation {
            let vc = CheckoutViewController()
            vc.hidesBottomBarWhenPushed = true
            vc.cartList = self.cartList
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "My Cart"
        view.backgroundColor = .white
        
        if let data = UserDefaults.standard.object(forKey: "Products") as? NSData {
            cartList = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Product]
            self.cartTableView.reloadData()
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
        
        if cartList.count == 0 {
            infoLabel.isHidden = false
            checkOutButton.isEnabled = false
            checkOutButton.backgroundColor = K.brandGray
        }else{
            infoLabel.isHidden = true
            checkOutButton.isEnabled = true
            checkOutButton.backgroundColor = K.brandRed
        }
        
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            cartList.remove(at: indexPath.row)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: cartList)
            UserDefaults.standard.setValue(data, forKey: "Products")
            tableView.endUpdates()
        }
    }
    
}

