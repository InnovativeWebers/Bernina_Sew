//
//  EventViewController.swift
//  Bernina Sew
//
//  Created by Cheng Liang(Louis) on 2021/6/28.
//

import UIKit
import SnapKit
import SCLAlertView

class EventViewController: UIViewController {
    
    var eventName: String?
    var eventDate: String?
    var eventLevel: String?
    var eventDescripton: String?
    
    var offset = 20
    
    
    let eventLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        lbl.backgroundColor = .blue
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.layer.cornerRadius = 10
        lbl.clipsToBounds = true

        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.backgroundColor = K.green
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.heightAnchor.constraint(equalToConstant: K.screenHeight / 12).isActive = true

        lbl.layer.cornerRadius = 13
        lbl.clipsToBounds = true
        return lbl
    }()
    
    let levelLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        lbl.backgroundColor = K.orange
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.heightAnchor.constraint(equalToConstant: K.screenHeight / 12).isActive = true

        lbl.layer.cornerRadius = 13
        lbl.clipsToBounds = true
        return lbl
    }()
    
    let descriptionTextView: UITextView = {
        let tf = UITextView()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isEditable = false
        tf.isSelectable = false
        tf.isScrollEnabled = false
        tf.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        
        
        return tf
    }()
    
    let bookingButton = Tools.setUpButton("Book", K.brandRed, 25)
    
    
    @objc func bookingAction(sender: UIButton){
        sender.showAnimation {
            SCLAlertView().showTitle("Booked", subTitle: "Check your bookings in 'Profile' tab", style: .success, colorStyle: 0x29BB89)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = .white
        eventLabel.text = eventName
        dateLabel.text = eventDate
        levelLabel.text = eventLevel
        descriptionTextView.text = eventDescripton
        
        dateLabel.widthAnchor.constraint(equalToConstant: (K.screenWidth - CGFloat(offset * 2) - 10) / 2 ).isActive = true
        levelLabel.widthAnchor.constraint(equalToConstant: (K.screenWidth - CGFloat(offset * 2) - 10) / 2 ).isActive = true
        eventLabel.heightAnchor.constraint(equalToConstant: K.screenHeight / 3).isActive = true
        
        view.addSubview(eventLabel)
        view.addSubview(dateLabel)
        view.addSubview(levelLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(bookingButton)
        
        bookingButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        bookingButton.setTitleColor(.white, for: .normal)
        
        eventLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.top.equalTo(view).offset(offset)
        }
        
        dateLabel.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(offset)
            make.top.equalTo(eventLabel.snp_bottomMargin).offset(offset)
        }
        
        levelLabel.snp.makeConstraints {(make) -> Void in
            make.right.equalTo(view).offset(-offset)
            make.top.equalTo(eventLabel.snp_bottomMargin).offset(offset)
        }
        
        descriptionTextView.snp.makeConstraints { make  in
            make.top.equalTo(levelLabel.snp_bottomMargin).offset(30)
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.bottom.equalTo(bookingButton.snp_topMargin).offset(-30)
        }
        
        
        bookingButton.snp.makeConstraints {(make) -> Void in
            make.left.equalTo(view).offset(offset)
            make.right.equalTo(view).offset(-offset)
            make.bottom.equalTo(view).offset(-40)
        }
        
        bookingButton.addTarget(self, action: #selector(bookingAction(sender:)), for: .touchUpInside)
        
    }
}
