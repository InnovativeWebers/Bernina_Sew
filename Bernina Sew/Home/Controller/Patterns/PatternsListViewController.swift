//
//  PatternsListViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/12.
//

import UIKit

class PatternsListViewController: UIViewController {

    let patternTableView = Tools.setUpTableView()
    var patternList: [Pattern]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.title = "Patterns"
        view.backgroundColor = .white
        patternTableView.delegate = self
        patternTableView.dataSource = self
        patternTableView.register(PatternTableViewCell.self, forCellReuseIdentifier: "PatternCell")
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


extension PatternsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patternList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCell", for: indexPath) as! PatternTableViewCell
        cell.patternImageView.sd_setImage(with: URL(string: patternList![indexPath.row].Image), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        cell.patternName.text = patternList![indexPath.row].Name
        cell.patternDescription.text = patternList![indexPath.row].Description
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PatternsViewController()
        vc.patternName = patternList![indexPath.row].Name
        vc.patternID = patternList![indexPath.row].ID
        vc.patternImgUrl = patternList![indexPath.row].Image
        vc.patterDescription = patternList![indexPath.row].Description
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
