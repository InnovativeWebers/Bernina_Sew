//
//  DesignsViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/29.
//

import UIKit
import SnapKit
class DesignsViewController: UIViewController {
    var designArray = [DesignModel]()
    let designTableView = Tools.setUpTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "My Designs"
        designTableView.delegate = self
        designTableView.dataSource = self
        designTableView.register(DesignCell.self, forCellReuseIdentifier: "DesignCell")
        
        if let data = UserDefaults.standard.object(forKey: "Designs") as? NSData {
            designArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [DesignModel]
        }
        
        designTableView.rowHeight = 120
        
        view.addSubview(designTableView)
        designTableView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(20)
            make.top.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
    }
    


}

extension DesignsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return designArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DesignCell", for: indexPath) as! DesignCell
        
        cell.patternImageView.sd_setImage(with: URL(string: designArray[indexPath.row].PatternImageURL!), completed: nil)
        cell.productImageView.sd_setImage(with: URL(string: designArray[indexPath.row].ProductImageURL!), completed: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)

            designArray.remove(at: indexPath.row)
            let data = NSKeyedArchiver.archivedData(withRootObject: designArray)
            UserDefaults.standard.setValue(data, forKey: "Designs")
            tableView.endUpdates()
        }
    }
    
}
