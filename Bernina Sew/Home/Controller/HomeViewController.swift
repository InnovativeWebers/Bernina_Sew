//
//  ViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/04/2021.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
   
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var featuredButton: UIButton!
    @IBOutlet weak var patternsButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    // normally we load the events from an API, however here we simply created a dummy event array since we weren't given an API
    let events: [Event] = [
        Event(eventName: "L1 Workhsop", level: "Beginner", date: "13-June-2021"),
        Event(eventName: "L2 Workhsop", level: "Intermediate", date: "26-June-2021"),
        Event(eventName: "L3 Workhsop", level: "Hard", date: "01-July-2021"),
    ]
    @IBOutlet weak var featuredProduct1: UIImageView!
    @IBOutlet weak var featuredProduct2: UIImageView!
    @IBOutlet weak var featuredProduct3: UIImageView!
    
    @IBOutlet weak var pattern1: UIImageView!
    @IBOutlet weak var pattern2: UIImageView!
    @IBOutlet weak var pattern3: UIImageView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func searchPressed(_ sender: UIButton) {
        sender.showAnimation {
            self.searchTextField.endEditing(true)
        }
        
    }
    var selectedRow: Int?
    var productList: [Product] = []
    
    @objc func dismissKeyboard() {
        searchTextField.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        searchTextField.delegate = self
        
        searchTextField.placeholder = "Search for products..."
        
        

        searchButton.layer.cornerRadius = 8

        self.title = "Home"
        
        featuredButton.layer.cornerRadius = 10
        patternsButton.layer.cornerRadius = 10
        eventsButton.layer.cornerRadius = 10
        
        let imageIcon = UIImage(systemName: "house.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![0].selectedImage = imageIcon
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        productList = loadJson(filename: "InputJSON")!.FeaturedProducts
        
        featuredProduct1.sd_setImage(with: URL(string: productList[0].Image), completed: nil)
        featuredProduct2.sd_setImage(with: URL(string: productList[1].Image), completed: nil)
        featuredProduct3.sd_setImage(with: URL(string: productList[2].Image), completed: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    
    func loadJson(filename fileName: String) -> ProductList? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                print(url)
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ProductList.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        
        return nil
 
    }
}


extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventTableViewCell
        
        cell.eventsLabel.text = events[indexPath.row].eventName
        cell.levelLabel.text = events[indexPath.row].level
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "HomeToEvent", sender: self)
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != ""{
//            return true
//        }else{
//            textField.placeholder = "Search for products..."
//            return false
//        }
//    }
}
