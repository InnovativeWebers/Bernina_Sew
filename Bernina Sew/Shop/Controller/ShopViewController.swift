
import UIKit
import SnapKit

class ShopViewController: UIViewController {
    
    let searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10
        
        return tf
    }()
    
    let searchButton = Tools.setUpButton("Search", K.brandRed, 12)
    
    @objc func searchPressed(sender: UIButton){
        sender.showAnimation {
            
        }
    }
    
    @objc func cartAction(sender: UIBarButtonItem) {
        let vc = CartViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let productTableView = Tools.setUpTableView()
    var productList = Tools.loadProductList(filename: "featuredProductJSON")?.FeaturedProducts
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = K.brandRed
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "My Cart", style: .done, target: self, action: #selector(self.cartAction(sender:)))
        
        self.title = "Shop"
        let imageIcon = UIImage(systemName: "cart.fill", withConfiguration: K.symbolConfig)?.withTintColor(K.brandRed, renderingMode: .alwaysOriginal)
        self.tabBarController?.tabBar.items![3].selectedImage = imageIcon
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchPressed(sender:)), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        view.addSubview(searchButton)
        view.addSubview(searchTextField)
        
        searchButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        searchTextField.placeholder = "Search for products..."
        searchButton.layer.cornerRadius = 8
        Tools.setHeight(searchTextField, 40)
        Tools.setHeight(searchButton, 40)
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
        
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "ProductCell")
        productTableView.rowHeight = 116
        productTableView.separatorStyle = .none
        
        view.addSubview(productTableView)
        productTableView.snp.makeConstraints { make  in
            make.top.equalTo(searchTextField.snp_bottomMargin).offset(10)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        

    }

}


extension ShopViewController: UITextFieldDelegate {
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


extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.productImageView.sd_setImage(with: URL(string: productList![indexPath.row].Image!), placeholderImage: UIImage(named: "placeHolder"), options: .highPriority, completed: nil)
        cell.productName.text = productList![indexPath.row].Name
        cell.productID = productList![indexPath.row].ID
        cell.productPriceValue = productList![indexPath.row].Price
        cell.productDescription = productList![indexPath.row].Description
        cell.productImageUrl = productList![indexPath.row].Image
        cell.selectionStyle = .none
        cell.productPrice.text = "$ \(productList![indexPath.row].Price!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductInfoViewController()
        vc.productImageUrl = productList![indexPath.row].Image
        vc.productPrice = "$ \(productList![indexPath.row].Price!)"
        vc.productID = productList![indexPath.row].ID
        vc.productName = productList![indexPath.row].Name
        vc.productDescription = productList![indexPath.row].Description
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
