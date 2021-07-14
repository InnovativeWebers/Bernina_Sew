//
//  ViewController.swift
//  Bernina Sew
//
//  Created by lunarian on 01/04/2021.
//

import UIKit
import SDWebImage
import NVActivityIndicatorView

class HomeViewController: UIViewController {
   
    
    @IBOutlet weak var eventsTableView: UITableView!
    @IBOutlet weak var featuredButton: UIButton!
    @IBOutlet weak var patternsButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
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

    var eventList: [Event] = []
    var productList: [Product] = []
    var patternsList: [Pattern] = []

    let loadingView = NVActivityIndicatorView(frame: CGRect(x: K.screenWidth / 2 - 50, y: K.screenHeight / 4, width: 100, height: 50), type: .lineScale, color: K.brandRed, padding: 1.0)
    
    let loadingView2 = NVActivityIndicatorView(frame: CGRect(x: K.screenWidth / 2 - 50, y: K.screenHeight / 3, width: 100, height: 50), type: .lineScale, color: K.brandRed, padding: 1.0)

    @objc func dismissKeyboard() {
        searchTextField.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        searchTextField.delegate = self
        
        searchTextField.placeholder = "Search for products..."
        searchButton.layer.cornerRadius = 8
        eventsTableView.rowHeight = 58
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        self.title = "Home"
        
        view.addSubview(loadingView)
        view.addSubview(loadingView2)
        
        featuredButton.layer.cornerRadius = 10
        patternsButton.layer.cornerRadius = 10
        eventsButton.layer.cornerRadius = 10
        
        let imageIcon = UIImage(systemName: "house.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![0].selectedImage = imageIcon
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        productList = Tools.loadProductList(filename: "InputJSON")!.FeaturedProducts
        
        loadingView.startAnimating()
        featuredProduct1.sd_setImage(with: URL(string: productList[0].Image), completed: nil)
        featuredProduct2.sd_setImage(with: URL(string: productList[1].Image), completed: nil)
        featuredProduct3.sd_setImage(with: URL(string: productList[2].Image), completed: nil)
        
        loadingView.stopAnimating()

        eventList = Tools.loadEventList(filename: "eventJSON")!.Events
        
        patternsList = Tools.loadPatternList(filename: "patternJSON")!.Patterns
        pattern1.sd_setImage(with: URL(string: patternsList[0].Image), completed: nil)
        pattern2.sd_setImage(with: URL(string: patternsList[1].Image), completed: nil)
        pattern3.sd_setImage(with: URL(string: patternsList[2].Image), completed: nil)
        
    }
    
   
}


extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! EventTableViewCell
        
        cell.eventsLabel.text = eventList[indexPath.row].Name
        cell.levelLabel.text = eventList[indexPath.row].Level
        cell.dateLabel.text = eventList[indexPath.row].Date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EventViewController()
        vc.eventName = eventList[indexPath.row].Name
        vc.eventDate = eventList[indexPath.row].Date
        vc.eventLevel = eventList[indexPath.row].Level
        vc.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

}
