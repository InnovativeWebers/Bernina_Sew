//
//  AddPostViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/13.
//

import UIKit
import SnapKit
import SCLAlertView

class AddPostViewController: UIViewController{
    
    let titleTextfield: UITextField = {
        let tf = UITextField()
        Tools.setHeight(tf, 40)
        tf.borderStyle = .none
        tf.layer.borderWidth = 2
        tf.layer.cornerRadius = 10
        tf.placeholder = "Enter a title here..."
        tf.setLeftPaddingPoints(10)
        return tf
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        Tools.setHeight(tv, 200)
        tv.text = "Enter details here..."
        tv.textColor = .lightGray
        tv.font = .systemFont(ofSize: 18, weight: .regular)
        tv.layer.borderWidth = 2
        tv.layer.cornerRadius = 10
        
        return tv
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Blog title"
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    let contentLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Details"
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()
    
    let offset = 20
    
    let postButton = Tools.setUpButton("Post", K.brandRed, 25)
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var blogs: [BlogModel] = []
    
    @objc func postAction(sender: UIButton) {
        sender.showAnimation { [self] in
            
            if let blogArray = UserDefaults.standard.object(forKey: "Blogs") as? NSData {
                blogs = NSKeyedUnarchiver.unarchiveObject(with: blogArray as Data) as! [BlogModel]
            }

            if titleTextfield.text != nil && titleTextfield.text != "" && contentTextView.text != "" && contentTextView.text != "Enter details here..." {
                let date = Date()
                
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let seconds = calendar.component(.second, from: date)
                
                let dateString = "\(year)-\(month)-\(day) \(hour):\(minutes):\(seconds)"
                
                let blog = BlogModel(BlogTitle: titleTextfield.text!, BlogContent: contentTextView.text!, Time: dateString)
                blogs.append(blog)

                
                let dataToStore = NSKeyedArchiver.archivedData(withRootObject: blogs)
                UserDefaults.standard.setValue(dataToStore, forKey: "Blogs")
                
                self.navigationController?.popViewController(animated: true)
            }else{
                SCLAlertView().showTitle("Missing fields", subTitle: "Please enter title and description", style: .warning, colorStyle: 0xC10000)
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = K.brandRed
        self.title = "Add post"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
                tap.cancelsTouchesInView = false
                view.addGestureRecognizer(tap)
        
        Tools.setHeight(postButton, 55)
        postButton.addTarget(self, action: #selector(postAction(sender:)), for: .touchUpInside)
        
        titleTextfield.delegate = self
        contentTextView.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(titleTextfield)
        view.addSubview(contentLabel)
        view.addSubview(contentTextView)
        view.addSubview(postButton)
        
        titleLabel.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(offset)
            make.left.equalTo(view).offset(offset)
        }
        titleTextfield.snp.makeConstraints { make  in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(offset / 2)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            
        }
        
        contentLabel.snp.makeConstraints { make  in
            make.top.equalTo(titleTextfield.snp_bottomMargin).offset(offset / 2)
            make.left.equalTo(view).offset(offset)
        }
        
        contentTextView.snp.makeConstraints { make  in
            make.top.equalTo(contentLabel.snp_bottomMargin).offset(offset/2)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        postButton.snp.makeConstraints { make  in
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.bottom.equalTo(view).offset(-offset * 2)
        }
        
    }
}

extension AddPostViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3.5
        textField.layer.borderColor = K.brandRed.cgColor
        textField.placeholder = nil
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.black.cgColor
        textField.placeholder = "Enter a title here..."
    }
}

extension AddPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 3.5
        textView.layer.borderColor = K.brandRed.cgColor
        textView.text = nil
        textView.textColor = UIColor.black

    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.black.cgColor
        textView.textColor = UIColor.lightGray
    }
}
