//
//  OrdersViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/14.
//

import UIKit
import SnapKit

class OrdersViewController: UIViewController {

    var orderArray = [OrderModel]()
    let orderTableView = Tools.setUpTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Orders"
        view.backgroundColor = .white
        

        if let data = UserDefaults.standard.object(forKey: "Orders") as? NSData {
            orderArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [OrderModel]
        }
        
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        orderTableView.rowHeight = 90

        view.addSubview(orderTableView)
        orderTableView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
        
        
    
    }

}


extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.orderNumLabel.text = "Order #\(indexPath.row)"
        cell.selectionStyle = .none
        cell.orderDateLabel.text = orderArray[indexPath.row].orderTime!
        cell.orderValueLabel.text = "$\(orderArray[indexPath.row].orderValue!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            orderArray.remove(at: indexPath.row)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: orderArray)
            UserDefaults.standard.setValue(data, forKey: "Orders")
            tableView.endUpdates()
        }
    }
    
    
    
}
