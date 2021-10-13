//
//  AddressViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/29.
//

import UIKit

class AddressViewController: UIViewController {

    let addButton: UIButton = {
        let button = UIButton()
        Tools.setHeight(button, 45)
        Tools.setWidth(button, 45)
        button.setImage(UIImage(named: "plus"), for: .normal)
        
        return button
    }()
    
    let offset = 20
    
    @objc func addAction(sender: UIButton){
        sender.showAnimation {
            let vc = AddAddressViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    let addressTableView = Tools.setUpTableView()
    var addressArray = [AddressModel]()

    

    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(true)
        self.title = "Address"
        view.backgroundColor = .white

        addButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        addressTableView.dataSource = self
        addressTableView.register(AddressCell.self, forCellReuseIdentifier: "AddressCell")
        
        addressTableView.rowHeight = 100
        

        if let data = UserDefaults.standard.object(forKey: "addresses") as? NSData {
            addressArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [AddressModel]
        }
        
        

        
        view.addSubview(addressTableView)
        addressTableView.snp.makeConstraints { make  in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
            
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-offset * 2)
            make.right.equalTo(view).offset(-offset)
        }
    }
    
}


extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as! AddressCell
        let firstName = addressArray[indexPath.row].firstName
        let lastName = addressArray[indexPath.row].lastName
        let phoneNum = addressArray[indexPath.row].phoneNum
        let suburb = addressArray[indexPath.row].suburb
        let state = addressArray[indexPath.row].state
        let postCode = addressArray[indexPath.row].postCode
        let addressLine1 = addressArray[indexPath.row].line1
        let addressLine2 = addressArray[indexPath.row].line2
        
        cell.nameLabel.text = "\(firstName!) \(lastName!)"
        cell.phoneNum.text = "\(phoneNum!)"
        cell.addressLine1.text = "\(addressLine1!)"
        cell.addressLine2.text = "\(addressLine2!)"
        cell.suburb.text = "\(suburb!) \(state!)\(postCode!)"
        
        return cell
    }
    
    
}
