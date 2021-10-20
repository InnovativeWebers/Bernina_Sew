//
//  PatternsViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/9/12.
//

import UIKit
import SnapKit
import SCLAlertView

class PatternsViewController: UIViewController {
    
    var patternName: String?
    var patternID: Int?
    var patterDescription: String?
    var patternImgUrl: String?
    var offset = 20
    
    let patternImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    
    let patternNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 25, weight: .semibold)
        return lbl
    }()
    
    let patternIDLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = K.brandGray
        return lbl
    }()
    
    let descriptionTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.isSelectable = false
        tv.isScrollEnabled = false
        tv.font = .systemFont(ofSize: 15, weight: .regular)
        return tv
    }()
    
    let addToFavsButton = Tools.setUpButton("Add to favorites", K.brandRed, 25)
    
    @objc func addAction(sender: UIButton){
        sender.showAnimation { [self] in
            var patternArray = [Pattern]()
            if let data = UserDefaults.standard.object(forKey: "Patterns") as? NSData {
            patternArray = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! [Pattern]
               }
            
            for pattern in patternArray {
                if pattern.ID == patternID! {
                    SCLAlertView().showTitle("Already added!", subTitle: "You have already added this pattern to favorites before.", style: .warning, colorStyle: 0xC10000)
                    
                    return
                }
            }
            
            let pattern = Pattern(ID: patternID!, Name: patternName!, Image: patternImgUrl!, Description: patterDescription!)
            
            patternArray.append(pattern)
            
            let data = NSKeyedArchiver.archivedData(withRootObject: patternArray)
            UserDefaults.standard.setValue(data, forKey: "Patterns")
            
            
            
            SCLAlertView().showTitle("Added", subTitle: "Check your favorites in 'profile' tab", style: .success, colorStyle: 0x29BB89)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = patternName!
        patternImage.sd_setImage(with: URL(string: patternImgUrl!), completed: nil)
        patternNameLabel.text = patternName!
        patternIDLabel.text = "\(patternID!)"
        descriptionTextView.text = patterDescription!
        addToFavsButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        Tools.setHeight(addToFavsButton, 55)
        view.backgroundColor = .white
        
        view.addSubview(patternImage)
        view.addSubview(patternNameLabel)
        view.addSubview(patternIDLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(addToFavsButton)
        
        patternImage.sd_setImage(with: URL(string: patternImgUrl!), completed: nil)
        
        Tools.setHeight(patternImage, Int(K.screenHeight) / 3)
        
        patternImage.snp.makeConstraints { make  in
            make.top.equalTo(view).offset(offset)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        patternNameLabel.snp.makeConstraints {  make  in
            make.top.equalTo(patternImage.snp_bottomMargin).offset(offset)
            make.left.equalTo(view).offset(offset)
        }
        
        patternIDLabel.snp.makeConstraints { make  in
            make.top.equalTo(patternNameLabel.snp_bottomMargin).offset(8)
            make.left.equalTo(view).offset(offset)
        }
        

        Tools.setHeight(descriptionTextView, Int(K.screenHeight) / 4)
        descriptionTextView.snp.makeConstraints { make  in
            make.top.equalTo(patternIDLabel.snp_bottomMargin).offset(10)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
        }
        
        addToFavsButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.bottom.equalTo(view).offset(-40)
        }
        

    }
}
