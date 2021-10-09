//
//  AddressViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/29.
//

import UIKit

class AddressViewController: UIViewController {

    let addButton: UIButton = {
        let button = UIButton()
        Tools.setHeight(button, 45)
        Tools.setWidth(button, 45)
        button.setImage(UIImage(named: "plus"), for: .normal)
        
        return button
    }()
    
    let offset = 20
    
    @objc func addAction(sender: UIButton){
        sender.showAnimation {
            let vc = AddAddressViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Address"
        view.backgroundColor = .white

        addButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-offset * 2)
            make.right.equalTo(view).offset(-offset)
        }
    }
    
}
