//
//  AddAddressViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/10/9.
//

import UIKit
import SnapKit
import MaterialComponents.MaterialTextControls_OutlinedTextAreas
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import DropDown
import SCLAlertView

class AddAddressViewController: UIViewController {
    
    let stateView = Tools.setUpButton("Select state", .white, 20)
    let stateDropDown = DropDown()
    @objc func stateAction(sender: UIButton){
        sender.showAnimation {
            self.stateDropDown.show()
        }
    }
    
    let firstNameTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "First name"
        tf.textContentType = .givenName
        tf.tintColor = K.brandRed
        tf.sizeToFit()
        Tools.setWidth(tf, (Int(K.screenWidth) - 60) / 2)
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    let lastNameTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "Last name"
        tf.sizeToFit()
        tf.textContentType = .familyName
        Tools.setWidth(tf, (Int(K.screenWidth) - 60) / 2)
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    let phoneTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "Phone number"
        tf.placeholder = "04xx-xxx-xxx"
        tf.textContentType = .telephoneNumber
        tf.sizeToFit()
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    let postCodeTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "ZIP"
        tf.textContentType = .postalCode
        tf.sizeToFit()
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    let suburbTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "Suburb or city"
        tf.textContentType = .addressCity
        tf.sizeToFit()
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    let addressLine1TextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "Address line 1"
        tf.textContentType = .addressCity
        tf.sizeToFit()
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    let addressLine2TextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "Address line 2 (Optional)"
        tf.textContentType = .addressCity
        tf.sizeToFit()
        Tools.setHeight(tf, 60)
        return tf
    }()
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func addAction(sender: UIButton) {
        sender.showAnimation { [self] in
        
            print(firstNameTextField.text)
            print(stateView.currentTitle)
            
            SCLAlertView().showTitle("Address added", subTitle: "The address has been added", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    let offset = 20
    
    let addButton = Tools.setUpButton("Add", K.brandRed, 25)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add an address"
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        stateView.addTarget(self, action: #selector(stateAction(sender:)), for: .touchUpInside)
        stateDropDown.anchorView = stateView
        stateDropDown.dataSource = ["QLD", "NSW", "ACT", "VIC", "TAS", "NT", "SA", "WA"]
        stateDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            stateView.setTitle(item, for: .normal)
        }
        
        addButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        
        view.addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { make  in
            make.left.equalTo(view).offset(offset)
            make.top.equalTo(view).offset(offset)
        }
        
        view.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { make  in
            make.right.equalTo(view).offset(-offset)
            make.top.equalTo(view).offset(offset)
        }
        
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make  in
            make.top.equalTo(firstNameTextField.snp_bottomMargin).offset(offset)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            
        }
        
        view.addSubview(stateView)
        stateView.setTitleColor(.black, for: .normal)
        stateView.layer.borderWidth = 1
        stateView.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        stateView.layer.cornerRadius = 6
        Tools.setHeight(stateView, 60)
        Tools.setWidth(stateView, (Int(K.screenWidth) - 60) / 3)
        stateView.snp.makeConstraints { make  in
            make.left.equalTo(view).offset(offset)
            make.top.equalTo(phoneTextField.snp_bottomMargin).offset(offset)
        }
        
        view.addSubview(suburbTextField)
        Tools.setWidth(suburbTextField, 150)
        suburbTextField.snp.makeConstraints { make  in
            make.left.equalTo(stateView.snp_rightMargin).offset(offset)
            make.top.equalTo(phoneTextField.snp_bottomMargin).offset(offset)
        }
        
        view.addSubview(postCodeTextField)
        postCodeTextField.snp.makeConstraints { make  in
            make.top.equalTo(phoneTextField.snp_bottomMargin).offset(offset)
            make.left.equalTo(suburbTextField.snp_rightMargin).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(addressLine1TextField)
        addressLine1TextField.snp.makeConstraints { make  in
            make.top.equalTo(suburbTextField.snp_bottomMargin).offset(offset)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(addressLine2TextField)
        addressLine2TextField.snp.makeConstraints { make  in
            make.top.equalTo(addressLine1TextField.snp_bottomMargin).offset(offset)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        view.addSubview(addButton)
        Tools.setHeight(addButton, 60)
        addButton.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-offset * 2)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
    }
    

}
