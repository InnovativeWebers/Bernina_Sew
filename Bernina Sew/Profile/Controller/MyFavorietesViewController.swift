//
//  MyFavorietesViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/30.
//

import UIKit

class MyFavorietesViewController: UIViewController {
    let patternTableView = Tools.setUpTableView()
    var patternList: [Pattern]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Favorites"
        view.backgroundColor = .white
        
        if let data = UserDefaults.standard.object(forKey: "Patterns") as? NSData {
            patternList = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Pattern]
        }
        
        
        
        
        patternTableView.delegate = self
        patternTableView.dataSource = self
        patternTableView.register(FavCell.self, forCellReuseIdentifier: "FavCell")
        patternTableView.rowHeight = 116
        
        view.addSubview(patternTableView)
        patternTableView.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }

    }
}


extension MyFavorietesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(patternList == nil){
            return 0
        }else{
            return patternList!.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavCell
        cell.patternImageView.sd_setImage(with: URL(string: patternList![indexPath.row].Image!), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        cell.patternName.text = patternList![indexPath.row].Name
        cell.patternDescription.text = patternList![indexPath.row].Description
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
            patternList?.remove(at: indexPath.row)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: patternList)
            UserDefaults.standard.setValue(data, forKey: "Patterns")
            tableView.endUpdates()
        }
    }
    
}
