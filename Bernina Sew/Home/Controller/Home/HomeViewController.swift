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
   
    

    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    let searchButton = Tools.setUpButton("Search", K.brandRed, 12)
    
    let featuredLabel = Tools.setUpHeadingLabel("Featured")
    let patternsLabel = Tools.setUpHeadingLabel("Patterns")
    let eventsLabel = Tools.setUpHeadingLabel("Events")
    

    let featureButton = Tools.setUpButton("More", K.brandRed, 12)
    let patternsButton = Tools.setUpButton("More", K.brandRed, 12)
    let eventsButton = Tools.setUpButton("More", K.brandRed, 12)
    let eventsTableView = Tools.setUpTableView()
    
    let featuredCollectionView = Tools.setUpCollectionView(10, 10, 60, 60)
    let patternsCollectionView = Tools.setUpCollectionView(10, 10, 60, 60)
    
    
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    var eventList: [Event] = []
    var productList: [Product] = []
    var patternsList: [Pattern] = []


    @objc func searchPressed(sender: UIButton) {
        sender.showAnimation {
        }
    }
    
    @objc func featuredPressed(sender: UIButton) {
        sender.showAnimation {
            let vc = ProductListViewController()
            vc.productList = self.productList
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @objc func patternsPressed(sender: UIButton) {
        sender.showAnimation {
            let vc = PatternsListViewController()
            vc.patternList = self.patternsList
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func eventsPressed(sender: UIButton) {
        sender.showAnimation {
            let vc = EventListViewController()
            vc.eventList = self.eventList
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func dismissKeyboard() {
        searchTextField.endEditing(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        let tabHeight = self.tabBarController?.tabBar.frame.size.height
        K.userDefaults.setValue(tabHeight, forKey: "tabHeight")
        
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = K.brandRed
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        searchTextField.delegate = self
        
        searchTextField.placeholder = "Search for products..."
        searchButton.layer.cornerRadius = 8
        eventsTableView.rowHeight = 68
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        
        
        if let index = self.eventsTableView.indexPathForSelectedRow{
            self.eventsTableView.deselectRow(at: index, animated: true)
        }

    
        
        let imageIcon = UIImage(systemName: "house.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![0].selectedImage = imageIcon
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        
        
        // load json files here, I've created these files manually and stored them locally,
        // normally these data should be fetched from an API
        productList = Tools.loadProductList(filename: "featuredProductJSON")!.FeaturedProducts
        
        eventList = Tools.loadEventList(filename: "eventJSON")!.Events
        
        patternsList = Tools.loadPatternList(filename: "patternJSON")!.Patterns
        
        
        let tableViewHeight = eventList.count * Int(eventsTableView.rowHeight)
        Tools.setHeight(eventsTableView, tableViewHeight)
        
        searchButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        featureButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        patternsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        eventsButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        Tools.setHeight(featureButton, 22)
        Tools.setHeight(patternsButton, 22)
        Tools.setHeight(eventsButton, 22)
        
        searchButton.addTarget(self, action: #selector(searchPressed(sender:)), for: .touchUpInside)
        featureButton.addTarget(self, action: #selector(featuredPressed(sender:)), for: .touchUpInside)
        patternsButton.addTarget(self, action: #selector(patternsPressed(sender:)), for: .touchUpInside)
        eventsButton.addTarget(self, action: #selector(eventsPressed(sender:)), for: .touchUpInside)
        
        scrollView.contentSize = CGSize(width: K.screenWidth, height: CGFloat(tableViewHeight + 90 + 100 + 50 + 100))
        
        eventsTableView.isScrollEnabled = false

        featuredCollectionView.delegate = self
        featuredCollectionView.dataSource = self
        patternsCollectionView.delegate = self
        patternsCollectionView.dataSource = self
        featuredCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        patternsCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        scrollView.addSubview(featuredLabel)
        scrollView.addSubview(featureButton)
        scrollView.addSubview(containerView)
        containerView.addSubview(featuredCollectionView)
        scrollView.addSubview(patternsLabel)
        scrollView.addSubview(patternsButton)
        scrollView.addSubview(patternsCollectionView)
        scrollView.addSubview(eventsLabel)
        scrollView.addSubview(eventsButton)
        scrollView.addSubview(eventsTableView)
        


        
        scrollView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(50)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.bottom.equalTo(view).offset(0)
        }
        
        Tools.setHeight(searchTextField, 40)
        Tools.setHeight(searchButton, 40)
        Tools.setHeight(containerView, 90)
        Tools.setHeight(patternsCollectionView, 90)


        
        searchTextField.setLeftPaddingPoints(10)
        searchTextField.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(searchButton.snp_leftMargin).offset(-16)
        }
        
        searchButton.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-16)
        }
        
        featuredLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(scrollView).offset(16)
            make.left.equalTo(scrollView).offset(16)
        }
        
        
        featureButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(featuredLabel.snp_rightMargin).offset(10)
            make.top.equalTo(scrollView).offset(24)
        }
        
        containerView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(featuredLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        featuredCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(containerView).offset(0)
            make.left.equalTo(containerView).offset(0)
            make.right.equalTo(containerView).offset(0)
            make.bottom.equalTo(containerView).offset(0)
        }
        
        patternsLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(containerView.snp_bottomMargin).offset(16)
            make.left.equalTo(scrollView).offset(16)
        }
        
        patternsButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(patternsLabel.snp_rightMargin).offset(10)
            make.top.equalTo(containerView.snp_bottomMargin).offset(24)
        }
        
        patternsCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(patternsLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
        }
        
        eventsLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(patternsCollectionView.snp_bottomMargin).offset(16)
            make.left.equalTo(scrollView).offset(16)
        }
        
        eventsButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(eventsLabel.snp_rightMargin).offset(10)
            make.top.equalTo(patternsCollectionView.snp_bottomMargin).offset(24)
        }
        
        eventsTableView.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(16)
            make.right.equalTo(view).offset(-16)
            make.top.equalTo(eventsLabel.snp_bottomMargin).offset(16)
        }
        
    
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
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension HomeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.layer.borderWidth = 2.5
        searchTextField.layer.borderColor = K.brandRed.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.borderWidth = 1.0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuredCollectionView {
            return productList.count
        }else{
            return patternsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        if collectionView == featuredCollectionView {
            cell.collectionImage.sd_setImage(with: URL(string: productList[indexPath.row].Image!), completed: nil)
        }else {
            cell.collectionImage.sd_setImage(with: URL(string: patternsList[indexPath.row].Image), completed: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featuredCollectionView {
            let vc = ProductInfoViewController()
            vc.productImageUrl = productList[indexPath.row].Image
            vc.productPrice = "$ \(productList[indexPath.row].Price!)"
            vc.productID = productList[indexPath.row].ID
            vc.productName = productList[indexPath.row].Name
            vc.productDescription = productList[indexPath.row].Description
            vc.productPriceValue = productList[indexPath.row].Price

            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = PatternsViewController()
            vc.patternName = patternsList[indexPath.row].Name
            vc.patternID = patternsList[indexPath.row].ID
            vc.patternImgUrl = patternsList[indexPath.row].Image
            vc.patterDescription = patternsList[indexPath.row].Description
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }

}



