//
//  MyBookingsViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/29.
//

import UIKit

class MyBookingsViewController: UIViewController {

    var eventList = [Event]()
    let eventTableView = Tools.setUpTableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "My Bookings"
        

        if let data = UserDefaults.standard.object(forKey: "Events") as? NSData {
        eventList = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Event]
           }

        eventTableView.delegate = self
        eventTableView.dataSource = self
        self.title = "Events"
        view.backgroundColor = .white
        
        eventTableView.rowHeight = 70
        
        eventTableView.register(EventListCell.self, forCellReuseIdentifier: "EventListCell")

        view.addSubview(eventTableView)
        eventTableView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(0)
        }
    }
    

}
extension MyBookingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListCell", for: indexPath) as! EventListCell
        cell.levelLabel.text = eventList[indexPath.row].Level
        cell.dateLabel.text = eventList[indexPath.row].Date
        cell.eventLabel.text = eventList[indexPath.row].Name
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EventViewController()
        vc.eventName = eventList[indexPath.row].Name
        vc.eventDate = eventList[indexPath.row].Date
        vc.eventLevel = eventList[indexPath.row].Level
        vc.eventDescripton = eventList[indexPath.row].Description
        vc.hidesBottomBarWhenPushed = true
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
