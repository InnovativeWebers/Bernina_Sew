//
//  EventListViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/14.
//

import UIKit
import SnapKit

class EventListViewController: UIViewController {
    
    var eventList: [Event]?
    let eventTableView = Tools.setUpTableView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTableView.delegate = self
        eventTableView.dataSource = self
        view.backgroundColor = .white
        
        eventTableView.register(EventListCell.self, forCellReuseIdentifier: "EventListCell")

        view.addSubview(eventTableView)
        eventTableView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath) as! EventListCell
        cell.levelLabel.text = eventList![indexPath.row].Level
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EventViewController()
        vc.eventName = eventList![indexPath.row].Name
        vc.eventDate = eventList![indexPath.row].Date
        vc.eventLevel = eventList![indexPath.row].Level
        vc.hidesBottomBarWhenPushed = true
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
