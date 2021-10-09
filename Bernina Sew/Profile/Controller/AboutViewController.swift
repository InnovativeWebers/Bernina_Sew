//
//  AboutViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/29.
//

import UIKit
import SnapKit

class AboutViewController: UIViewController {

    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "BerninaLogo")
        Tools.setHeight(iv, 250)
        Tools.setWidth(iv, 250)
        iv.layer.cornerRadius = 15
        iv.layer.borderWidth = 5
        iv.layer.borderColor = K.brandRed.cgColor
        return iv
    }()
    
    let addressLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Shop 12 / 725 Gympie Road, Chermside QLD 4032"
        lbl.font = .systemFont(ofSize: 12)
        lbl.textAlignment = .center
        return lbl
    }()
    
    let phoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0412270933"
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 12)
        return lbl
    }()
    
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "contact@berninachermside.com.au"
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 12)
        return lbl
    }()
    
    let versionLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Version: \(K.AppVersion)"
        lbl.textColor = K.brandRed
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "About"
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make  in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(view).offset(K.screenHeight / 6)
        }
        
        view.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make  in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(logoImageView.snp_bottomMargin).offset(16)
        }
        
        view.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make  in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(addressLabel.snp_bottomMargin).offset(10)
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make  in
            make.centerX.equalTo(view.snp_centerX)
            make.top.equalTo(phoneLabel.snp_bottomMargin).offset(10)
        }
        
        view.addSubview(versionLabel)
        versionLabel.snp.makeConstraints { make  in
            make.bottom.equalTo(view).offset(-24)
            make.centerX.equalTo(view)
        }
        
    }


}
