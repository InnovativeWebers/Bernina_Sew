//
//  Tools.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/7/13.
//

import UIKit


struct Tools {
    public static func setUpButton(_ btnTitle: String, _ color: UIColor, _ fontSize: Int) -> UIButton {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.backgroundColor = color
        btn.setTitle(btnTitle, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: CGFloat(fontSize), weight: .bold)
        return btn
    }
    
    public static func loadProductList(filename fileName: String) -> ProductList? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
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
    
    public static func loadEventList(filename fileName: String) -> EventList? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(EventList.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    public static func loadPatternList(filename fileName: String) -> PatternList? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(PatternList.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
    public static func setHeight( _ sender: UIView, _ height: Int){
        sender.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
    }
    
    public static func setWidth(_ sender: UIView, _ width: Int){
        sender.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
    }
    
    public static func setUpTableView() -> UITableView {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        
        return tv
    }
    
    public static func setUpHeadingLabel(_ text: String) -> UILabel {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        lbl.text = text
        return lbl
    }
    
    public static func setUpImageView() -> UIImageView {
        let iv = UIImageView()
        iv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 70).isActive = true
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
        iv.layer.borderWidth = 1.5
        iv.layer.borderColor = UIColor.black.cgColor
        return iv
    }
    
    public static func setUpContainerView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.addShadow()
        view.backgroundColor = K.lightGray
        return view
    }
    
    public static func setUpLoginAlert(_ vc: UIViewController) -> UIAlertController {
        let alertController = UIAlertController(title: "You're not logged in!", message: "Please log in first!", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "Login", style: UIAlertAction.Style.default) {
            UIAlertAction in
            vc.performSegue(withIdentifier: "profileToLogin", sender: vc)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
            print("Canelled")
        }
        

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

            
        return alertController

    }
    
    
    public static func setUpCollectionView(_ lineSpacing: Int, _ interItemSpacing: Int, _ cellWidth: Int, _ cellHeight: Int) -> UICollectionView {
        let cellSize = CGSize(width: cellWidth, height: cellHeight)

        let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
            layout.itemSize = cellSize
           layout.minimumLineSpacing = CGFloat(lineSpacing)
           layout.minimumInteritemSpacing = CGFloat(interItemSpacing)
           let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
           cv.translatesAutoresizingMaskIntoConstraints = false
           cv.widthAnchor.constraint(equalToConstant: K.screenWidth - 32).isActive = true
           cv.backgroundColor = .white
           cv.showsHorizontalScrollIndicator = false
           return cv
    }
   

    
}


public extension UIView {
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 2.0, height: 0.5)
        self.layer.shadowOpacity = 0.9
        self.layer.shadowRadius = 1.0
    }

}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}


extension TimeZone {
    static let gmt = TimeZone(secondsFromGMT: 0)!
}
extension Formatter {
    static let date = DateFormatter()
}

extension Date {
    func localizedDescription(dateStyle: DateFormatter.Style = .medium,
                              timeStyle: DateFormatter.Style = .medium,
                           in timeZone : TimeZone = .current,
                              locale   : Locale = .current) -> String {
        Formatter.date.locale = locale
        Formatter.date.timeZone = timeZone
        Formatter.date.dateStyle = dateStyle
        Formatter.date.timeStyle = timeStyle
        return Formatter.date.string(from: self)
    }
    var localizedDescription: String { localizedDescription() }
}

