//
//  CheckoutViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/30.
//

import UIKit
import SCLAlertView

class CheckoutViewController: UIViewController {

    var cartList: [Product]?
    let confirmButton = Tools.setUpButton("Proceed", K.brandRed, 25)
    let addAddressButton = Tools.setUpButton("Add an address", K.brandRed, 25)
    
    let productCollectionView: UICollectionView = {
        let cellSize = CGSize(width: 60, height: 60)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = CGFloat(10)
        layout.minimumInteritemSpacing = CGFloat(10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        Tools.setHeight(cv, 80)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    let addressCollectionView: UICollectionView = {
        let cellSize = CGSize(width: K.screenWidth - 40, height: 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = CGFloat(10)
        layout.minimumInteritemSpacing = CGFloat(10)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        Tools.setHeight(cv, 120)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.borderColor = UIColor.black.cgColor
        cv.layer.borderWidth = 3
        cv.layer.cornerRadius = 10
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    
    let priceContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 3
        v.layer.borderColor = UIColor.black.cgColor
        Tools.setHeight(v, 130)
        return v
    }()
    
    let paymentTableView = Tools.setUpTableView()
    
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = K.brandRed
        lbl.font = .systemFont(ofSize: 20, weight: .semibold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    func GetTotalPrice(_ cart: [Product]) -> Int{
        var price = 0
        for product in cart {
            price = price + product.Price!
        }
        return price
    }
    
    let paymentMethodsArray = ["Credit Card", "PayPal"]
    
    
    var addressArray: [AddressModel]?
    
    @objc func confirmAction(sender: UIButton){
        sender.showAnimation {
            SCLAlertView().showTitle("Success", subTitle: "Order has been submitted!", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    @objc func addAddress(sender: UIButton){
        sender.showAnimation {
            let vc = AddAddressViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Check out"
        let price = GetTotalPrice(cartList!)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
        
        paymentTableView.dataSource = self
        paymentTableView.delegate = self
        paymentTableView.register(PaymentCell.self, forCellReuseIdentifier: "PaymentCell")
        
        addressCollectionView.dataSource = self
        addressCollectionView.delegate = self
        addressCollectionView.register(AddressCollectionCell.self, forCellWithReuseIdentifier: "AddressCollectionCell")
        
        confirmButton.addTarget(self, action: #selector(confirmAction(sender:)), for: .touchUpInside)
        addAddressButton.addTarget(self, action: #selector(addAddress(sender:)), for: .touchUpInside)
        
        if let data = UserDefaults.standard.object(forKey: "addresses") as? NSData {
            addressArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [AddressModel]
        }
        
        
        priceLabel.text = "Total price: $\(price)"
        view.addSubview(priceContainer)
        priceContainer.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        priceContainer.addSubview(productCollectionView)
        productCollectionView.snp.makeConstraints { make  in
            make.top.equalTo(priceContainer).offset(10)
            make.left.equalTo(priceContainer).offset(16)
            make.right.equalTo(priceContainer).offset(-16)
        }
        
        
        priceContainer.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make  in
            make.top.equalTo(productCollectionView.snp_bottomMargin).offset(10)
            make.centerX.equalTo(priceContainer.snp_centerX)
        }
        
        paymentTableView.layer.borderWidth = 3
        paymentTableView.layer.borderColor = UIColor.black.cgColor
        paymentTableView.layer.cornerRadius = 10
        paymentTableView.isScrollEnabled = false
    
        paymentTableView.rowHeight = 60
        Tools.setHeight(paymentTableView, 120)
        
        view.addSubview(paymentTableView)
        paymentTableView.snp.makeConstraints { make  in
            make.top.equalTo(priceContainer.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(addressCollectionView)
        addressCollectionView.snp.makeConstraints { make in
            make.top.equalTo(paymentTableView.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        
        if addressArray?.count == 0 {
            addressCollectionView.isHidden = true
            addAddressButton.isHidden = false
        }else{
            addressCollectionView.isHidden = false
            addAddressButton.isHidden = true
        }
        
        view.addSubview(addAddressButton)
        Tools.setHeight(addAddressButton, 40)
        addAddressButton.snp.makeConstraints { make in
            make.top.equalTo(paymentTableView.snp_bottomMargin).offset(20)
            make.left.equalTo(view).offset(100)
            make.right.equalTo(view).offset(-100)
        }
        
        
        view.addSubview(confirmButton)
        Tools.setHeight(confirmButton, 55)
        confirmButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(view).offset(-20)
        }
        
        

    }
}

extension CheckoutViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == productCollectionView {
            return cartList!.count
        }else{
            return addressArray!.count
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
            cell.collectionImage.sd_setImage(with: URL(string: cartList![indexPath.row].Image!), completed: nil)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddressCollectionCell", for: indexPath) as! AddressCollectionCell
            let firstName = addressArray![indexPath.row].firstName
            let lastName = addressArray![indexPath.row].lastName
            let phoneNum = addressArray![indexPath.row].phoneNum
            let suburb = addressArray![indexPath.row].suburb
            let state = addressArray![indexPath.row].state
            let postCode = addressArray![indexPath.row].postCode
            let addressLine1 = addressArray![indexPath.row].line1
            let addressLine2 = addressArray![indexPath.row].line2
            
            cell.nameLabel.text = "\(firstName!) \(lastName!)"
            cell.phoneNum.text = "\(phoneNum!)"
            cell.addressLine1.text = "\(addressLine1!)"
            cell.addressLine2.text = "\(addressLine2!)"
            cell.suburb.text = "\(suburb!) \(state!)\(postCode!)"
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == addressCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! AddressCollectionCell
            cell.container.layer.borderWidth = 3
            cell.container.layer.borderColor = K.brandRed.cgColor
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == addressCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! AddressCollectionCell
            cell.container.layer.borderWidth = 3
            cell.container.layer.borderColor = K.brandGray.cgColor
            
        }
    }

}

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethodsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentCell
        cell.paymentLabel.text = paymentMethodsArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentCell
        cell.container.layer.borderColor = K.brandRed.cgColor
        let symbolConfig = UIImage.SymbolConfiguration(scale: .small)
        cell.selectionImageView.image = UIImage(systemName: "circle.circle.fill", withConfiguration: symbolConfig)?.withTintColor(K.brandRed).withRenderingMode(.alwaysOriginal)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentCell
        cell.container.layer.borderColor = K.brandGray.cgColor
        let symbolConfig = UIImage.SymbolConfiguration(scale: .small)
        cell.selectionImageView.image = UIImage(systemName: "circle.circle", withConfiguration: symbolConfig)?.withTintColor(K.brandGray).withRenderingMode(.alwaysOriginal)
    }
    
}
